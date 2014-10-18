require 'minitest/autorun'
require File.expand_path("shop")

class TestJournal < MiniTest::Test
 def setup
    @journal = Journal.new title: "PHP"
 end

 def test_title
    assert_equal "PHP", @journal.title
 end

 def test_default
    assert_equal 10.00, @journal.value
 end

 def test_new
    assert_equal true, @journal.new_record
 end

 def test_save
    @journal.save
    assert_equal false, @journal.new_record
    @journal.destroy
 end

 def test_destroy
    @journal.save
    @journal.destroy
    assert_equal true, @journal.destroyed
 end
end
