require 'rison/parslet_parser'
require 'rison/parslet_transform'
require 'rison/dump'

module Rison
  class ParseError < StandardError; end

  def self.load(string)
    ParsletTransform.new.apply(ParsletParser.new.parse(string))
  rescue Parslet::ParseFailed => exception
    raise ParseError, "Invalid Rison input. #{exception.message}"
  end
end
