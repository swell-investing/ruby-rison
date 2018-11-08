require 'minitest/autorun'

$:.unshift 'lib'

require 'rison'

describe 'Rison load method' do
  it 'parses true' do
    Rison.load('!t').must_equal(true)
  end

  it 'parses false' do
    Rison.load('!f').must_equal(false)
  end

  it 'parses nil' do
    assert_nil Rison.load('!n')
  end

  it 'parses zero' do
    Rison.load('0').must_equal(0)
  end

  it 'parses positive integers' do
    Rison.load('1').must_equal(1)
    Rison.load('42').must_equal(42)
  end

  it 'parses negative integers' do
    Rison.load('-3').must_equal(-3)
    Rison.load('-33').must_equal(-33)
  end

  it 'parses integers with exponents' do
    Rison.load('1e30').must_equal(10 ** 30)
    Rison.load('1e-30').must_equal(10 ** -30)
  end

  it 'parses fractional numbers as rationals' do
    Rison.load('1.5').must_equal(Rational(3, 2))
    Rison.load('99.99').must_equal(Rational(9999, 100))
  end

  it 'parses fractional numbers with exponents' do
    Rison.load('1.5e2').must_equal(150)
  end

  it 'parses ids as symbols' do
    Rison.load('a').must_equal(:a)
    Rison.load('a-z').must_equal(:'a-z')
    Rison.load('domain.com').must_equal(:'domain.com')
  end

  it 'parses strings' do
    Rison.load(%('')).must_equal('')
    Rison.load(%('0a')).must_equal('0a')
    Rison.load(%('-h')).must_equal('-h')
    Rison.load(%('abc def')).must_equal('abc def')
    Rison.load(%('user@domain.com')).must_equal('user@domain.com')
    Rison.load(%('US $10')).must_equal('US $10')
  end

  it 'parses strings with escape sequences' do
    Rison.load(%('wow!!')).must_equal('wow!')
    Rison.load(%('can!'t')).must_equal("can't")
  end

  it 'parses objects as hashes' do
    Rison.load('()').must_equal({})
    Rison.load('(a:0)').must_equal(:a => 0)
    Rison.load('(a:0,b:1)').must_equal(:a => 0, :b => 1)
    Rison.load('(a:0,b:foo,c:\'23skidoo\')').must_equal(:a => 0, :b => :foo, :c => '23skidoo')
    Rison.load('(id:!n,type:/common/document)').must_equal(:id => nil, :type => :'/common/document')
  end

  it 'parses arrays' do
    Rison.load('!()').must_equal([])
    Rison.load("!(!t)").must_equal([true])
    Rison.load("!(!t,!f)").must_equal([true, false])
    Rison.load("!(!t,!f,!n,123)").must_equal([true, false, nil, 123])
  end

  it 'raises an exception when given invalid input' do
    proc { Rison.load('-h') }.must_raise(Rison::ParseError)
    proc { Rison.load('1.5e+2') }.must_raise(Rison::ParseError)
    proc { Rison.load('1.5E2') }.must_raise(Rison::ParseError)
    proc { Rison.load('1.5E+2') }.must_raise(Rison::ParseError)
    proc { Rison.load('1.5E-2') }.must_raise(Rison::ParseError)
    proc { Rison.load('abc def') }.must_raise(Rison::ParseError)
    proc { Rison.load('US $10') }.must_raise(Rison::ParseError)
    proc { Rison.load('user@domain.com') }.must_raise(Rison::ParseError)
  end
end
