require 'rational'

module Rison
  def self.dump(object)
    case object
      when NilClass then '!n'

      when TrueClass then '!t'

      when FalseClass then '!f'

      when Symbol then dump(object.to_s)

      when Rational then object.to_f.to_s

      when Numeric then object.to_s

      when String
        if object.empty?
          "''"
        elsif id?(object)
          object
        else
          quote(object)
        end

      when Hash
        '(%s)' % (object.sort_by { |k, v| k.to_s }.map { |(k, v)| '%s:%s' % [ dump(k), dump(v) ] } * ',')

      when Array
        '!(%s)' % (object.map { |x| dump(x) } * ',')

      else
        raise ArgumentError, 'cannot serialize: %p' % object
    end
  end

  def self.quote(string)
    "'%s'" % escape(string)
  end

  def self.escape(string)
    string.gsub('!', '!!').gsub("'", "!'")
  end

  def self.id?(string)
    string !~ /^(-|\d)/ && string !~  /['!:(),*@$ ]/
  end
end
