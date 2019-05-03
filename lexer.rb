# lexer.rb
require 'strscan'
class Lexer
  REGEXP = /(\d+)|\+|\*|\/|\(|\)/.freeze

  def tokenize(expression)
    s = StringScanner.new(expression)
    tokens = []

    while s.scan_until(REGEXP)
      token = s.matched
      tokens << ((token =~ /\d+/) ? token.to_i : token.to_sym)
    end

    tokens
  end
end
