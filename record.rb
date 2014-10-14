module ActiveFile
 def save
  #copiar de journal
 end

 def destroy
  #copiar de journal
 end

 module ClassMethods
  def field(name)
     @fields ||= []
     @fields << name
  end

  def find(id)
    #copiar
  end

  def next_id
    #copiar
  end

  def self.included(base)
     base.extend ClassMethods
  end

  private

  def serialize
   #copiar
  end
end


class Journal
 include ActiveFile
end
