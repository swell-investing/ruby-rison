require 'minitest/autorun'

$:.unshift 'lib'

require 'rison'

describe 'Rison dump method' do
  it 'encodes true' do
    Rison.dump(true).must_equal('!t')
  end

  it 'encodes false' do
    Rison.dump(false).must_equal('!f')
  end

  it 'encodes nil' do
    Rison.dump(nil).must_equal('!n')
  end

  it 'encodes zero' do
    Rison.dump(0).must_equal('0')
  end

  it 'encodes positive integers' do
    Rison.dump(1).must_equal('1')
    Rison.dump(42).must_equal('42')
  end

  it 'encodes negative integers' do
    Rison.dump(-3).must_equal('-3')
    Rison.dump(-33).must_equal('-33')
  end

  it 'encodes rationals as fractional numbers' do
    Rison.dump(Rational(3, 2)).must_equal('1.5')
    Rison.dump(Rational(9999, 100)).must_equal('99.99')
  end

  it 'encodes symbols as ids' do
    Rison.dump(:a).must_equal('a')
    Rison.dump(:'a-z').must_equal('a-z')
    Rison.dump(:'domain.com').must_equal('domain.com')
  end

  it 'encodes strings' do
    Rison.dump('').must_equal(%(''))
    Rison.dump('0a').must_equal(%('0a'))
    Rison.dump('-h').must_equal(%('-h'))
    Rison.dump('abc def').must_equal(%('abc def'))
    Rison.dump('user@domain.com').must_equal(%('user@domain.com'))
    Rison.dump('US $10').must_equal(%('US $10'))
  end

  it 'encodes strings with escape sequences' do
    Rison.dump(%(can't)).must_equal(%('can!'t'))
    Rison.dump('wow!').must_equal(%('wow!!'))
  end

  it 'encodes hashes as objects' do
    Rison.dump({}).must_equal('()')
    Rison.dump({:a => 0}).must_equal('(a:0)')
    Rison.dump({:a => 0, :b => 1}).must_equal('(a:0,b:1)')
    Rison.dump({:a => 0, :b => :foo, :c => '23skidoo'}).must_equal('(a:0,b:foo,c:\'23skidoo\')')
    Rison.dump({:id => nil, :type => :'/common/document'}).must_equal('(id:!n,type:/common/document)')
    Rison.dump({'id' => nil, 'type' => '/common/document'}).must_equal(%(('id':!n,'type':'/common/document')))
  end

  it 'encodes arrays' do
    Rison.dump([]).must_equal('!()')
    Rison.dump([true]).must_equal('!(!t)')
    Rison.dump([true, false]).must_equal('!(!t,!f)')
    Rison.dump([true, false, nil, 123]).must_equal('!(!t,!f,!n,123)')
  end

  it 'raises an exception when given an undumpable object' do
    proc { Rison.dump(Array) }.must_raise(Rison::DumpError)
  end
end
