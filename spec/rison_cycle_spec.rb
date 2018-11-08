require 'minitest/autorun'
require 'rantly/minitest_extensions'
require 'rantly/shrinks'

$:.unshift 'lib'

require 'rison'

MAXIMUM_DEPTH = 4

def input_property(depth = 0)
  return scalar_input_property if depth >= MAXIMUM_DEPTH

  freq(
    [4, proc { scalar_input_property }],
    [1, proc { array_input_property(depth+1) }],
    [1, proc { hash_input_property(depth+1) }]
  )
end

def scalar_input_property
  freq(
    [3, :integer],
    [2, :float],
    [3, :string],
    [1, :boolean],
    [1, [:literal, nil]],
  )
end

def array_input_property(depth)
  Deflating.new(
    array {
      input_property(depth)
    }
  )
end

def hash_input_property(depth)
  dict {
    [ string, input_property(depth) ]
  }
end

def encodable_form(data)
  case data
  when Deflating then data.array.map{|elem| encodable_form(elem) }
  when Hash then data.map{|key, val| [key, encodable_form(val)] }.to_h
  else data
  end
end

def expected_decoded_form(data)
  case data
  when Deflating then data.array.map{|elem| expected_decoded_form(elem) }
  when Hash then data.map{|key, val| [key, expected_decoded_form(val)] }.to_h
  when Float then Rational(data.to_s)
  else data
  end
end

describe 'Rison dumping and loading' do
  make_my_diffs_pretty!

  it "recreates data through dump and load" do
    property_of { input_property }.check do |data|
      encoded = Rison.dump(encodable_form(data))
      decoded = Rison.load(encoded)

      if data.nil?
        assert_nil decoded
      else
        decoded.must_equal(expected_decoded_form(data))
      end
    end
  end
end
