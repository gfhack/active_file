require 'minitest/autorun'

class TestJournal < MiniTest::Unit::TestCase
 def setup
    @journal = Journal.new title: "Teste Unitário"
 end

 def testTitle
    assert_equal "Teste Unitário", @journal.title
 end

 def testDefaultValue
    skip "test later"
 end

 def testSave
    skip "test later"
 end

 def testDestroy
    skip "test later"
 end
end
