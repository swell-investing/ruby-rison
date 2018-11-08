require 'rison/parslet_parser'
require 'rison/parslet_transform'
require 'rison/dump'

module Rison
  ID_CHAR_PATTERN = /[a-zA-Z_\.\/~\-0-9]/.freeze # TODO: any non-ASCII Unicode character
  ID_START_PATTERN = /[a-zA-Z_\.\/~]/.freeze
  ID_PATTERN = /^#{ID_START_PATTERN.source}(?:#{ID_CHAR_PATTERN.source})*$/.freeze

  class ParseError < StandardError; end

  def self.load(string)
    ParsletTransform.new.apply(ParsletParser.new.parse(string))
  rescue Parslet::ParseFailed => exception
    raise ParseError, "Invalid Rison input. #{exception.message}"
  end
end
