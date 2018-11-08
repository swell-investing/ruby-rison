require 'parslet'

module Rison
  class ParsletParser < Parslet::Parser
    root(:value)

    rule(:value) { t | f | n | number | string | id | object | array }

    rule(:object) { str(?() >> members >> str(?)) | str('()').as(:empty_object) }

    rule(:array) { str('!(') >> elements >> str(?)) | str('!()').as(:empty_array) }

    rule(:string) { str(?') >> strchars.repeat.as(:string) >> str(?') }

    rule(:number) { int >> exp | int >> frac >> exp | int >> frac | int }

    rule(:elements) { value.as(:array_value) >> str(?,) >> elements.as(:array_elements) | value.as(:array_value) }

    rule(:members) { pair.as(:object_pair) >> str(?,) >> members.as(:object_members) | pair }

    rule(:pair) { key.as(:key) >> str(?:) >> value.as(:value) }

    rule(:key) { id | string }

    rule(:id) { (idstart >> idchars | idstart).as(:identifier) }

    rule(:idchars) { idchar.repeat(1) }

    rule(:idchar) { match(Rison::ID_CHAR_PATTERN) }

    rule(:idstart) { match(Rison::ID_START_PATTERN) }

    rule(:int) { (str('-').maybe >> (non_zero_digit >> digits | digit)).as(:int) }

    rule(:frac) { str(?.) >> digits.as(:frac) }

    rule(:exp) { str(?e) >> (str(?-).maybe >> digits).as(:exp) }

    rule(:strchars) { strchar.repeat(1) }

    rule(:strchar) { str(?!) >> str(?').as(:chr) | str(?!) >> str(?!).as(:chr) | match('[^\'\!]').as(:chr) }

    rule(:non_zero_digit) { match('[1-9]') }

    rule(:digits) { digit.repeat(1) }

    rule(:digit) { match('[0-9]') }

    rule(:t) { str('!t').as(:tfn) }

    rule(:f) { str('!f').as(:tfn) }

    rule(:n) { str('!n').as(:tfn) }
  end
end
