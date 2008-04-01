require 'rational'
require 'test/unit'
require 'rison'

class RisonParserTests < Test::Unit::TestCase

  def rison(string)
    Rison.load(string)
  end

  def assert_invalid(string)
    assert_raises(Rison::ParseError) { rison(string) }
  end
  
  # cf. http://mjtemplate.org/examples/rison.html
  
  def test_true
    assert_equal true, rison('!t')
  end
  
  def test_false
    assert_equal false, rison('!f')
  end
  
  def test_null
    assert_equal nil, rison('!n')
  end
  
  def test_zero
    assert_equal 0, rison('0')
  end
  
  def test_positive_integer
    assert_equal 1, rison('1')
    assert_equal 12, rison('12')
  end
  
  def test_negative_integer
    assert_equal -3, rison('-3')
    assert_equal -33, rison('-33')
  end
  
  def test_rational
    assert_equal Rational(3, 2), rison('1.5')
    assert_equal Rational(9999, 100), rison('99.99')
  end    
  
  def test_positive_exponent
    assert_equal 10**30, rison('1e30')
  end
  
  def test_negative_exponent
    assert_equal 10**-30, rison('1e-30')
  end
  
  def test_fraction_and_exponent
    assert_equal 150, rison('1.5e2')
  end

  def test_ids
    %w( a a-z domain.com ).each { |s| assert_equal s.to_sym, rison(s) }
  end
  
  def test_strings
    assert_equal '', rison("''")
    assert_equal '0a', rison("'0a'")
    assert_equal '-h', rison("'-h'")
    assert_equal "can't", rison("'can!'t'")
    assert_equal 'wow!', rison("'wow!!'")
    assert_equal 'abc def', rison("'abc def'")
    assert_equal 'user@domain.com', rison("'user@domain.com'")
    assert_equal 'US $10', rison("'US $10'")
  end

  def test_empty_object
    assert_equal Hash.new, rison('()')
  end
  
  def test_non_empty_objects
    expected = {:a => 0}
    assert_equal expected, rison('(a:0)')
  
    expected = {:id => nil, :type => :'/common/document'}
    assert_equal expected, rison('(id:!n,type:/common/document)')
  end
  
  def test_empty_array
    assert_equal [], rison('!()')
  end
  
  def test_array
    assert_equal [ true, false, nil, '' ], rison(%{!(!t,!f,!n,'')})
  end
  
  def test_invalid_expressions
    assert_invalid '-h'
    assert_invalid '1.5e+2'
    assert_invalid '1.5E2'
    assert_invalid '1.5E+2'
    assert_invalid '1.5E-2'
    assert_invalid 'abc def'
    assert_invalid 'US $10'
    assert_invalid 'user@domain.com'
  end
  
end