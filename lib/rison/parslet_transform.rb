require 'parslet'
require 'rational'

module Rison
  class ParsletTransform < Parslet::Transform
    rule(tfn: '!t') { true }

    rule(tfn: '!f') { false }

    rule(tfn: '!n') { nil }

    rule(int: simple(:value)) { value.to_i }

    rule(int: simple(:int), exp: simple(:exp)) { Rison::Number(int, nil, exp) }

    rule(int: simple(:int), frac: simple(:frac)) { Rison::Number(int, frac) }

    rule(int: simple(:int), frac: simple(:frac), exp: simple(:exp)) { Rison::Number(int, frac, exp) }

    rule(identifier: simple(:value)) { value.to_s.to_sym }

    rule(chr: simple(:chr)) { chr.to_s }

    rule(string: subtree(:characters)) { characters.join }

    rule(key: subtree(:k), value: subtree(:v)) { {k => v} }

    rule(empty_object: '()') { Hash.new }

    rule(object_pair: subtree(:pair), object_members: subtree(:members)) { pair.merge(members) }

    rule(empty_array: '!()') { [] }

    rule(array_value: subtree(:h)) { [h] }

    rule(array_value: subtree(:h), array_elements: subtree(:t)) { [h] + t }
  end

  def self.Number(int, frac = nil, exp = nil)
    base = frac ? int.to_i + Rational(frac.to_i, 10 ** frac.to_s.length) : int.to_i

    exp ? base * 10 ** exp.to_i : base
  end
end
