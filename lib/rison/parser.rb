require 'dhaka'
require 'rison/grammar'

module Rison
  class Parser < Dhaka::CompiledParser
  
    self.grammar = Rison::Grammar
  
    start_with 0
  
    at_state(48) {
      for_symbols("'") { shift_to 2 }
      for_symbols("object") { shift_to 25 }
      for_symbols("value") { shift_to 50 }
      for_symbols("number") { shift_to 46 }
      for_symbols("!") { shift_to 47 }
      for_symbols("string") { shift_to 26 }
      for_symbols("array") { shift_to 28 }
      for_symbols("idstart") { shift_to 38 }
      for_symbols("integer_token") { shift_to 5 }
      for_symbols("!t") { shift_to 24 }
      for_symbols(")") { shift_to 49 }
      for_symbols("idstart_safe_token") { shift_to 14 }
      for_symbols("!f") { shift_to 27 }
      for_symbols("(") { shift_to 29 }
      for_symbols("id") { shift_to 53 }
      for_symbols("int") { shift_to 8 }
      for_symbols("!n") { shift_to 1 }
      for_symbols("elements") { shift_to 54 }
    }
  
    at_state(47) {
      for_symbols("(") { shift_to 48 }
    }
  
    at_state(22) {
      for_symbols(",", ":", "_End_", ")") { reduce_with "non_empty_string" }
    }
  
    at_state(19) {
      for_symbols("!!", "idstart_safe_token", "integer_token", "!'", "'", "char_token", "idchar_safe_token") { reduce_with "strchar_num" }
    }
  
    at_state(5) {
      for_symbols("!!", ",", "frac_token", "idstart_safe_token", "integer_token", ":", "!'", "_End_", "'", "exponent_token", "char_token", ")", "idchar_safe_token") { reduce_with "integer_literal" }
    }
  
    at_state(54) {
      for_symbols(")") { shift_to 55 }
    }
  
    at_state(45) {
      for_symbols(",", ")") { reduce_with "pair_key_value" }
    }
  
    at_state(41) {
      for_symbols(",", ":", "_End_", ")") { reduce_with "idchars_idchars" }
    }
  
    at_state(31) {
      for_symbols(",", "_End_", ")") { reduce_with "non_empty_object" }
    }
  
    at_state(8) {
      for_symbols("exp") { shift_to 9 }
      for_symbols("exponent_token") { shift_to 13 }
      for_symbols("frac") { shift_to 11 }
      for_symbols("frac_token") { shift_to 10 }
      for_symbols("!!", ",", "idstart_safe_token", "integer_token", "!'", "_End_", "'", "char_token", ")", "idchar_safe_token") { reduce_with "number_int" }
    }
  
    at_state(7) {
      for_symbols("!!", ",", "idstart_safe_token", "integer_token", ":", "!'", "_End_", "'", "char_token", ")", "idchar_safe_token") { reduce_with "idchar_char" }
    }
  
    at_state(53) {
      for_symbols(",", "_End_", ")") { reduce_with "value_id" }
    }
  
    at_state(21) {
      for_symbols("'") { shift_to 22 }
    }
  
    at_state(55) {
      for_symbols(",", "_End_", ")") { reduce_with "non_empty_array" }
    }
  
    at_state(52) {
      for_symbols(")") { reduce_with "element_values" }
    }
  
    at_state(44) {
      for_symbols("'") { shift_to 2 }
      for_symbols("object") { shift_to 25 }
      for_symbols("number") { shift_to 46 }
      for_symbols("!") { shift_to 47 }
      for_symbols("string") { shift_to 26 }
      for_symbols("array") { shift_to 28 }
      for_symbols("idstart") { shift_to 38 }
      for_symbols("value") { shift_to 45 }
      for_symbols("integer_token") { shift_to 5 }
      for_symbols("!t") { shift_to 24 }
      for_symbols("idstart_safe_token") { shift_to 14 }
      for_symbols("!f") { shift_to 27 }
      for_symbols("(") { shift_to 29 }
      for_symbols("id") { shift_to 53 }
      for_symbols("int") { shift_to 8 }
      for_symbols("!n") { shift_to 1 }
    }
  
    at_state(42) {
      for_symbols(",", ":", "_End_", ")") { reduce_with "id_idstart_idchars" }
    }
  
    at_state(36) {
      for_symbols("members") { shift_to 37 }
      for_symbols("'") { shift_to 2 }
      for_symbols("key") { shift_to 43 }
      for_symbols("idstart") { shift_to 38 }
      for_symbols("string") { shift_to 33 }
      for_symbols("idstart_safe_token") { shift_to 14 }
      for_symbols("pair") { shift_to 35 }
      for_symbols("id") { shift_to 34 }
    }
  
    at_state(3) {
      for_symbols(",", ":", "_End_", ")") { reduce_with "empty_string" }
    }
  
    at_state(39) {
      for_symbols(",", ":", "_End_", ")") { reduce_with "idchars_int" }
    }
  
    at_state(35) {
      for_symbols(",") { shift_to 36 }
      for_symbols(")") { reduce_with "member_pair" }
    }
  
    at_state(27) {
      for_symbols(",", "_End_", ")") { reduce_with "value_false" }
    }
  
    at_state(18) {
      for_symbols("!!", "idstart_safe_token", "integer_token", "!'", "'", "char_token", "idchar_safe_token") { reduce_with "strchar_quoted_exclamation" }
    }
  
    at_state(11) {
      for_symbols("exp") { shift_to 12 }
      for_symbols("!!", ",", "idstart_safe_token", "integer_token", "!'", "_End_", "'", "char_token", ")", "idchar_safe_token") { reduce_with "number_int_frac" }
      for_symbols("exponent_token") { shift_to 13 }
    }
  
    at_state(51) {
      for_symbols("'") { shift_to 2 }
      for_symbols("object") { shift_to 25 }
      for_symbols("value") { shift_to 50 }
      for_symbols("elements") { shift_to 52 }
      for_symbols("number") { shift_to 46 }
      for_symbols("!") { shift_to 47 }
      for_symbols("string") { shift_to 26 }
      for_symbols("array") { shift_to 28 }
      for_symbols("idstart") { shift_to 38 }
      for_symbols("integer_token") { shift_to 5 }
      for_symbols("!t") { shift_to 24 }
      for_symbols("idstart_safe_token") { shift_to 14 }
      for_symbols("!f") { shift_to 27 }
      for_symbols("(") { shift_to 29 }
      for_symbols("id") { shift_to 53 }
      for_symbols("int") { shift_to 8 }
      for_symbols("!n") { shift_to 1 }
    }
  
    at_state(50) {
      for_symbols(",") { shift_to 51 }
      for_symbols(")") { reduce_with "element_value" }
    }
  
    at_state(43) {
      for_symbols(":") { shift_to 44 }
    }
  
    at_state(38) {
      for_symbols("idchars") { shift_to 42 }
      for_symbols(",", ":", "_End_", ")") { reduce_with "id_idstart" }
      for_symbols("idstart") { shift_to 17 }
      for_symbols("integer_token") { shift_to 5 }
      for_symbols("idstart_safe_token") { shift_to 14 }
      for_symbols("idchar") { shift_to 40 }
      for_symbols("idchar_safe_token") { shift_to 7 }
      for_symbols("int") { shift_to 39 }
    }
  
    at_state(37) {
      for_symbols(")") { reduce_with "member_pairs" }
    }
  
    at_state(15) {
      for_symbols("!!", "idstart_safe_token", "integer_token", "!'", "'", "char_token", "idchar_safe_token") { reduce_with "strchar_idchar" }
    }
  
    at_state(12) {
      for_symbols("!!", ",", "idstart_safe_token", "integer_token", "!'", "_End_", "'", "char_token", ")", "idchar_safe_token") { reduce_with "number_int_frac_exp" }
    }
  
    at_state(40) {
      for_symbols(",", ":", "_End_", ")") { reduce_with "idchars_idchar" }
      for_symbols("idstart") { shift_to 17 }
      for_symbols("integer_token") { shift_to 5 }
      for_symbols("idchars") { shift_to 41 }
      for_symbols("idstart_safe_token") { shift_to 14 }
      for_symbols("idchar") { shift_to 40 }
      for_symbols("idchar_safe_token") { shift_to 7 }
      for_symbols("int") { shift_to 39 }
    }
  
    at_state(34) {
      for_symbols(":") { reduce_with "key_id" }
    }
  
    at_state(32) {
      for_symbols(",", "_End_", ")") { reduce_with "empty_object" }
    }
  
    at_state(23) {
      for_symbols("_End_") { reduce_with "start" }
    }
  
    at_state(17) {
      for_symbols("!!", ",", "idstart_safe_token", "integer_token", ":", "!'", "_End_", "'", "char_token", ")", "idchar_safe_token") { reduce_with "idchar_idstart" }
    }
  
    at_state(16) {
      for_symbols("idstart") { shift_to 17 }
      for_symbols("!'") { shift_to 6 }
      for_symbols("strchars") { shift_to 20 }
      for_symbols("'") { reduce_with "strchars_char" }
      for_symbols("integer_token") { shift_to 5 }
      for_symbols("idchar") { shift_to 15 }
      for_symbols("char_token") { shift_to 4 }
      for_symbols("idstart_safe_token") { shift_to 14 }
      for_symbols("strchar") { shift_to 16 }
      for_symbols("idchar_safe_token") { shift_to 7 }
      for_symbols("int") { shift_to 8 }
      for_symbols("number") { shift_to 19 }
      for_symbols("!!") { shift_to 18 }
    }
  
    at_state(4) {
      for_symbols("!!", "idstart_safe_token", "integer_token", "!'", "'", "char_token", "idchar_safe_token") { reduce_with "strchar_char" }
    }
  
    at_state(49) {
      for_symbols(",", "_End_", ")") { reduce_with "empty_array" }
    }
  
    at_state(25) {
      for_symbols(",", "_End_", ")") { reduce_with "value_object" }
    }
  
    at_state(10) {
      for_symbols("!!", ",", "idstart_safe_token", "integer_token", "!'", "_End_", "'", "exponent_token", "char_token", ")", "idchar_safe_token") { reduce_with "frac_literal" }
    }
  
    at_state(28) {
      for_symbols(",", "_End_", ")") { reduce_with "value_array" }
    }
  
    at_state(26) {
      for_symbols(",", "_End_", ")") { reduce_with "value_string" }
    }
  
    at_state(0) {
      for_symbols("'") { shift_to 2 }
      for_symbols("object") { shift_to 25 }
      for_symbols("value") { shift_to 23 }
      for_symbols("number") { shift_to 46 }
      for_symbols("!") { shift_to 47 }
      for_symbols("string") { shift_to 26 }
      for_symbols("array") { shift_to 28 }
      for_symbols("idstart") { shift_to 38 }
      for_symbols("integer_token") { shift_to 5 }
      for_symbols("!t") { shift_to 24 }
      for_symbols("idstart_safe_token") { shift_to 14 }
      for_symbols("!f") { shift_to 27 }
      for_symbols("(") { shift_to 29 }
      for_symbols("id") { shift_to 53 }
      for_symbols("int") { shift_to 8 }
      for_symbols("!n") { shift_to 1 }
    }
  
    at_state(46) {
      for_symbols(",", "_End_", ")") { reduce_with "value_number" }
    }
  
    at_state(24) {
      for_symbols(",", "_End_", ")") { reduce_with "value_true" }
    }
  
    at_state(20) {
      for_symbols("'") { reduce_with "strchars_chars" }
    }
  
    at_state(13) {
      for_symbols("!!", ",", "idstart_safe_token", "integer_token", "!'", "_End_", "'", "char_token", ")", "idchar_safe_token") { reduce_with "exponent_literal" }
    }
  
    at_state(9) {
      for_symbols("!!", ",", "idstart_safe_token", "integer_token", "!'", "_End_", "'", "char_token", ")", "idchar_safe_token") { reduce_with "number_int_exp" }
    }
  
    at_state(1) {
      for_symbols(",", "_End_", ")") { reduce_with "value_null" }
    }
  
    at_state(33) {
      for_symbols(":") { reduce_with "key_string" }
    }
  
    at_state(30) {
      for_symbols(")") { shift_to 31 }
    }
  
    at_state(29) {
      for_symbols("'") { shift_to 2 }
      for_symbols("members") { shift_to 30 }
      for_symbols("key") { shift_to 43 }
      for_symbols("idstart") { shift_to 38 }
      for_symbols("string") { shift_to 33 }
      for_symbols("idstart_safe_token") { shift_to 14 }
      for_symbols(")") { shift_to 32 }
      for_symbols("pair") { shift_to 35 }
      for_symbols("id") { shift_to 34 }
    }
  
    at_state(14) {
      for_symbols("!!", ",", "idstart_safe_token", "integer_token", ":", "!'", "_End_", "'", "char_token", ")", "idchar_safe_token") { reduce_with "idstart_char" }
    }
  
    at_state(6) {
      for_symbols("!!", "idstart_safe_token", "integer_token", "!'", "'", "char_token", "idchar_safe_token") { reduce_with "strchar_quoted_single_quote" }
    }
  
    at_state(2) {
      for_symbols("'") { shift_to 3 }
      for_symbols("idstart") { shift_to 17 }
      for_symbols("!'") { shift_to 6 }
      for_symbols("integer_token") { shift_to 5 }
      for_symbols("idchar") { shift_to 15 }
      for_symbols("char_token") { shift_to 4 }
      for_symbols("idstart_safe_token") { shift_to 14 }
      for_symbols("strchar") { shift_to 16 }
      for_symbols("idchar_safe_token") { shift_to 7 }
      for_symbols("int") { shift_to 8 }
      for_symbols("strchars") { shift_to 21 }
      for_symbols("number") { shift_to 19 }
      for_symbols("!!") { shift_to 18 }
    }
  
  end
end
