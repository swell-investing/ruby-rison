require 'dhaka'
require 'rison/lexer'
require 'rison/parser'
require 'rison/evaluator'
require 'rison/dump'

module Rison

  class ParseError < ArgumentError
    attr_reader :result
    
    def initialize(invalid_string, result)
      @result = result
      
      super "invalid Rison string: %p" % invalid_string
    end
  end
  
  def self.load(data)
    lexed = lex(data)
    
    parsed = parse(lexed)
    
    raise ParseError.new(data, parsed) if parsed.has_error?
    
    evaluate(parsed)
  end

  
  LEXER = Dhaka::Lexer.new(LexerSpec)
  
  EVALUATOR = Evaluator.new
  
  def self.lex(data)
    LEXER.lex(data.to_s)
  end
  
  def self.parse(lexed)
    Parser.parse(lexed)
  end
  
  def self.evaluate(parsed)
    EVALUATOR.evaluate(parsed)
  end

end