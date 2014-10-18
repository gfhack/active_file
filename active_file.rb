require 'fileutils'

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
  
      File.open("db/#{self.class.name.downcase}/#{@id}.yml", "w+") do |file|
         file.puts serialize
      end
   end

   def destroy
      unless @destroyed or @new_record
         @destroyed = true
         FileUtils.rm "db/#{self.class.name.downcase}/#{@id}.yml"
      end
   end

   module ClassMethods
      attr_reader :fields

      def find(id)
         raise DocumentNotFound,
            "Arquivo db/revistas/#{@id}.yml não encontrado.", caller
         unless File.exists?("db/#{self.class.name.downcase}/#{@id}.yml")
         end

         YAML.load File.open("db/#{self.class.name.downcase}/#{@id}", "r")
      end

      def next_id
         time = Time.now
	 time.hash
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

      def method_missing(name, *args, &block)
         super unless name.to_s =~ /^find_by_(.*)/
	
	 argument = args.first
         field = name.to_s.split("_").last
         
         super if @fields.include? field
	 
         load_all.select do |object|
	    should_select? object, field, argument
	 end
      end
      
      private
      
      def should_select?(object, field, argument)
          if argument.kind_of? Regexp
	     object.send(field) =~ argument
	  else		
	     object.send(field) == argument
	  end
      end
      
      def load_all
         Dir.glob("db/#{self.name.downcase}/*.yml").map do |file|
	     deserialize file
         end
      end

      def deserialize(file)
         YAML.load File.open(file, "r")
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
