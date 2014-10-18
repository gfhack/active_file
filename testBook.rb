require 'minitest/autorun'
require File.expand_path("shop")

class TestJournal < MiniTest::Test
 def setup
    @book = Book.new title: "PHP", pages: 140, isbn: 999, author: "Vlad", category: "Terror"
 end

 def test_title
    assert_equal "PHP", @book.title
 end

 def test_pages
    assert_equal 140, @book.pages
 end
 
 def test_isbn
    assert_equal 999, @book.isbn
 end
 
 def test_author
    assert_equal "Vlad", @book.author
 end
 
 def test_category
    assert_equal "Terror", @book.category
 end
 
 def test_default
    assert_equal 40.00, @book.value
 end

 def test_new
    assert_equal true, @book.new_record
 end

 def test_save
    @book.save
    assert_equal false, @book.new_record
    @book.destroy
 end

 def test_destroy
    @book.save
    @book.destroy
    assert_equal true, @book.destroyed
 end
end
