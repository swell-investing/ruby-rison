require 'rational'
require 'dhaka'
require 'rison/grammar'

module Rison
  class Evaluator < Dhaka::Evaluator
    self.grammar = Grammar

    define_evaluation_rules do
      for_empty_object do
        {}
      end

      for_non_empty_object do
        evaluate(child_nodes[1])
      end

      # for_member_pair

      for_member_pairs do
        evaluate(child_nodes[2]).merge(evaluate(child_nodes[0]))
      end

      for_pair_key_value do
        { evaluate(child_nodes[0]) => evaluate(child_nodes[2]) }
      end

      for_empty_array do
        []
      end

      for_non_empty_array do
        evaluate(child_nodes[2])
      end

      for_element_value do
        [ evaluate(child_nodes[0]) ]
      end

      for_element_values do
        [ evaluate(child_nodes[0]) ] + evaluate(child_nodes[2])
      end

      # for_key_id do

      # for_key_string do

      # for_value_id do

      # for_value_string

      # for_value_number do

      # for_value_object do

      # for_value_array do

      for_value_true do
        true
      end

      for_value_false do
        false
      end

      for_value_null do
        nil
      end

      for_id_idstart do
        evaluate(child_nodes[0]).to_sym
      end

      for_id_idstart_idchars do
        (evaluate(child_nodes[0]) + evaluate(child_nodes[1])).to_sym
      end

      # for_idchars_idchar

      for_idchars_idchars do
        evaluate(child_nodes[0]) + evaluate(child_nodes[1])
      end

      for_idchars_int do
        evaluate(child_nodes[0]).to_s
      end

      for_idchar_char do
        child_nodes[0].token.value
      end

      # for_idchar_idstart

      for_idstart_char do
        child_nodes[0].token.value
      end

      for_empty_string do
        ''
      end

      for_non_empty_string do
        evaluate(child_nodes[1]).inject { |s, c| s + c }
      end

      for_strchars_char do
        [ evaluate(child_nodes[0]) ]
      end

      for_strchars_chars do
        [ evaluate(child_nodes[0]) ] + evaluate(child_nodes[1])
      end

      for_strchar_char do
        child_nodes[0].token.value
      end

      for_strchar_quoted_exclamation do
        '!'
      end

      for_strchar_quoted_single_quote do
        "'"
      end

      # for_strchar_idchar

      for_strchar_num do
        evaluate(child_nodes[0]).to_s
      end

      # for_number_int

      for_number_int_frac do
        evaluate(child_nodes[0]) + evaluate(child_nodes[1])
      end

      for_number_int_exp do
        evaluate(child_nodes[0]) * evaluate(child_nodes[1])
      end

      for_number_int_frac_exp do
        (evaluate(child_nodes[0]) + evaluate(child_nodes[1])) * evaluate(child_nodes[2])
      end

      for_integer_literal do
        token = child_nodes[0].token.value
        token =~ /^(-?)(\d+?)$/

        $1.empty?? $2.to_i : - $2.to_i
      end

      for_frac_literal do
        token = child_nodes[0].token.value
        token =~ /^\.(\d+?)$/

        Rational($1.to_i, 10 ** $1.length)
      end

      for_exponent_literal do
        token = child_nodes[0].token.value
        token =~ /^e(-?)(\d+?)$/

        10 ** ($1.empty?? $2.to_i : - $2.to_i)
      end
    end
  end
end
