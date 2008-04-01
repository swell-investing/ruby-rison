require 'rational'
require 'test/unit'
require 'rison'
require 'rison/dump'

class RisonDumpTests < Test::Unit::TestCase
  def r(object)
    Rison.dump(object)
  end
  
  def test_true
    assert_equal '!t', r(true)
  end
  
  def test_false
    assert_equal '!f', r(false)
  end
  
  def test_nil
    assert_equal '!n', r(nil)
  end
  
  def test_integers
    assert_equal '0', r(0)
    assert_equal '42', r(42)
    assert_equal '-42', r(-42)
  end
  
  def test_fractions
    assert_equal '1.5', r(Rational(3, 2))
    assert_equal '99.99', r(Rational(9999, 100))
  end
  
  def test_ids
    ['a', 'a-z', 'domain.com'].each { |s| assert_equal s, r(s) }
  end
  
  def test_strings
    assert_equal "''", r('')
    assert_equal "'0a'", r('0a')
    assert_equal "'-h'", r('-h')
    assert_equal "'can!'t'", r("can't")
    assert_equal "'wow!!'", r('wow!')
    assert_equal "'abc def'", r('abc def')
    assert_equal "'user@domain.com'", r('user@domain.com')
    assert_equal "'US $10'", r('US $10')
  end
  
  def test_empty_object
    assert_equal '()', r({})
  end
  
  def test_non_empty_objects
    assert_equal '(a:0)', r({:a => 0})
    assert_equal '(id:!n,type:/common/document)', r({'id' => nil, 'type' => '/common/document'})
    assert_equal '(id:!n,type:/common/document)', r({:id => nil, :type => :'/common/document'})
  end
  
  def test_empty_array
    assert_equal '!()', r([])
  end
  
  def test_non_empty_arrays
    assert_equal %{!(!t,!f,!n,'')}, r([true, false, nil, ''])
  end
  
  def test_undumpable_objects
    assert_raises(ArgumentError) { r(Array) }
  end
end