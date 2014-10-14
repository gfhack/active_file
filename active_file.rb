module ActiveFile
   class Field
      attr_reader :name, :required, :default
  
      def initialize(name, required, default)
         @name, @required, @default = name, required, default
      end

      def to_assign
         "@#{@name} = #{@name}"
      end

      def to_argument
         "#{@name}: #{@default}"
      end

      def to_attr
         ":#{@name}"
      end
   end

   def save
      @new_record = false
  
      File.open("db/revistas/#{@id}.yml") do |file|
         file.puts serialize
      end
   end

   def destroy
      unless @destroyed or @new_record
         @destroyed = true
         FileUtils.rm "db/revistas/#{@id}.yml"
      end
   end

   module ClassMethods
      attr_reader :fields

      def find(id)
         raise DocumentNotFound,
            "Arquivo db/revistas/#{@id}.yml não encontrado.", caller
         unless File.exists?("db/revistas/#{@id}.yml")
         end

         YAML.load File.open("db/revistas/#{@id}", "r")
      end

      def next_id
         Dir.glob("db/revistas/*.yml").size + 1
      end

      def field(name, required: false, default: "")
         @fields ||= []
         @fields << Field.new(name, required, default)

         self.class_eval %Q$
            attr_reader :id, :destroyed, :new_record, #{@fields.map(&:to_attr).join(", ")}

            def initialize(#{@fields.map(&:to_argument).join(", ")})
               @id = self.class.next_id
               @destroyed = false
               @new_record = true
               #{@fields.map(&:to_assign).join("\n")}
            end
         $
      end
   end

   def self.included(base)
      base.extend ClassMethods
   end

   private

   def serialize
      YAML.dump self
   end
end