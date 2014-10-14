class Report
 def initialize(library)
    @library = library
 end

 def total
    @library.books.map(&:value).inject(:+)
 end
end
