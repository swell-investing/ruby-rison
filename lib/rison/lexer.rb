require 'dhaka'

module Rison
  class LexerSpec < Dhaka::LexerSpecification

    [ ['!!', nil],
      ["!'", nil],
      ['!t', nil],
      ['!f', nil],
      ['!n', nil],

      ['\(', '('],
      ['\)', ')'],
      ['!', '!'],

      [',', nil],
      [':', nil],
      ["'", nil],

      ['e-?\d+', 'exponent_token'],
      ['\.\d+', 'frac_token'],
      ['-?\d+', 'integer_token'],
      
      ["[^\\-0-9'!:(),*@$ ]", 'idstart_safe_token'],
      ["[^'!:(),*@$ ]", 'idchar_safe_token'],
      ["[^'!]", 'char_token']      
    
    ].each do |(pattern, token)|
      for_pattern(pattern) { create_token(token || pattern) }
    end

  end
end