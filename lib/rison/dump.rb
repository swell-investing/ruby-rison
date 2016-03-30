require 'rational'

module Rison
  NIL = '!n'.freeze

  TRUE = '!t'.freeze

  FALSE = '!f'.freeze

  class DumpError < StandardError; end

  def self.dump(object)
    case object
      when NilClass then NIL

      when TrueClass then TRUE

      when FalseClass then FALSE

      when Symbol then object.to_s

      when Rational then object.to_f.to_s

      when Numeric then object.to_s

      when String then "'#{escape(object)}'"

      when Hash then '(%s)' % object.map { |(k, v)| dump_pair(k, v) }.join(?,)

      when Array then '!(%s)' % object.map { |member| dump(member) }.join(?,)

      else
        raise DumpError, "Cannot encode #{object.class} objects"
    end
  end

  def self.dump_pair(key, value)
    key.is_a?(Symbol) ? "#{key}:#{dump(value)}" : "#{dump(key.to_s)}:#{dump(value)}"
  end

  def self.escape(string)
    string.gsub('!', '!!').gsub("'", "!'")
  end
end
