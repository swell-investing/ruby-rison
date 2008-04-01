require 'dhaka'

module Rison
  class Grammar < Dhaka::Grammar

    for_symbol(Dhaka::START_SYMBOL_NAME) do
      start %w| value |
    end

    for_symbol 'object' do
      empty_object %w| ( ) |
      non_empty_object %w| ( members ) |
    end
  
    for_symbol 'members' do
      member_pair %w| pair |
      member_pairs %w| pair , members |
    end
  
    for_symbol 'pair' do
      pair_key_value %w| key : value |
    end
  
    for_symbol 'array' do
      empty_array %w| ! ( ) |
      non_empty_array %w| ! ( elements ) |
    end
  
    for_symbol 'elements' do
      element_value %w| value |
      element_values %w| value , elements |
    end
  
    for_symbol 'key' do
      key_id %w| id |
      key_string %w| string |
    end
  
    for_symbol 'value' do
      value_id %w| id |
      value_string %w| string |
      value_number %w| number |
      value_object %w| object |
      value_array %w| array |
      value_true %w| !t |
      value_false %w| !f |
      value_null %w| !n |
    end
  
    for_symbol 'id' do
      id_idstart %w| idstart |
      id_idstart_idchars %w| idstart idchars |
    end
  
    for_symbol 'idchars' do
      idchars_idchar %w| idchar |
      idchars_idchars %w| idchar idchars |
      idchars_int %w| int |
    end
    
    for_symbol 'idchar' do
      # any Unicode character not in '!:(),*@$
      idchar_char %w| idchar_safe_token |
      idchar_idstart %w| idstart |
    end
  
    for_symbol 'idstart' do
      # any Unicode character not in -, digit, or idchar
      idstart_char %w| idstart_safe_token |
    end
  
    for_symbol 'string' do
      empty_string %w| ' ' |
      non_empty_string %w| ' strchars ' |
    end
  
    for_symbol 'strchars' do
      strchars_char %w| strchar |
      strchars_chars %w| strchar strchars |
    end
  
    for_symbol 'strchar' do
      # any Unicode character not in ' or !
      # !!
      # !'
      strchar_char %w| char_token |
      strchar_quoted_exclamation %w| !! |
      strchar_quoted_single_quote %w| !' |
      strchar_idchar %w| idchar |
      strchar_num %w| number |
    end
  
    for_symbol 'number' do
      number_int %w| int |
      number_int_frac %w| int frac |
      number_int_exp %w| int exp |
      number_int_frac_exp %w| int frac exp |
    end
  
    for_symbol 'int' do
      integer_literal %w| integer_token |
    end
  
    for_symbol 'frac' do
      frac_literal %w| frac_token |
    end
      
    for_symbol 'exp' do
      exponent_literal %w| exponent_token |
    end

  end
end

