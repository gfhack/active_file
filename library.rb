class Library
 attr_reader :books

 def initialize
    @database = Database.new
 end

 def add(media)
    save media do
       medias << media
    end
 end

 def medias
    @medias ||= @database.load
 end

 def each
    medias.each { |media| yield media }
 end
 
 def medias_per_category(category)
    @medias.select do |media|
       media.category == category if media.respond_to? :category
    end
 end
 
 private

 def save(media)
    @database.save media
    yield
 end
end
