class Book
   attr_accessor :isbn, :pages, :value, :category, :author
   attr_reader :title

   def initialize(author, title, isbn = "1", pages, value, category)
      @author = author
      @isbn = isbn
      @pages = pages
      @value = value
      @category = category
      @title = title
   end
   
   def hash
      @isbn.hash
   end

   def eql?(other)
      @isbn == other.isbn
   end
end
