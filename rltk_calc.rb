require 'rltk'

class Calculator
  class Lexer < RLTK::Lexer
    rule(/\+/) { :PLS }
    rule(/-/)  { :SUB }
    rule(/\*/) { :MUL }
    rule(/\//) { :DIV }

    rule(/\(/) { :LPAREN }
    rule(/\)/) { :RPAREN }

    rule(/[0-9]+/) { |t| [:NUM, t.to_i] }

    rule(/\s/)

    # extension
    rule(/,/)   { :COMMA }
    rule(/pow/) { :POW }
    rule(/!/)   { :FACT }
  end

  class Parser < RLTK::Parser
    left  :PLS, :SUB, :POW
    left  :MUL, :DIV, :FACT

    production(:e) do
      clause('NUM') { |n| n }

      clause('LPAREN e RPAREN') { |_, e, _| e }

      # unary
      clause('PLS e') { |_, e| e }
      clause('SUB e') { |_, e| -e }

      # binary
      clause('e PLS e') { |e0, _, e1| e0 + e1 }
      clause('e SUB e') { |e0, _, e1| e0 - e1 }
      clause('e MUL e') { |e0, _, e1| e0 * e1 }
      clause('e DIV e') { |e0, _, e1| e0 / e1 }

      # extension
      clause('e FACT') { |e, _| (1..e).reduce(1, :*) }
      clause('POW LPAREN e COMMA e RPAREN') { |_, _, base, _, exp, _| base ** exp }
    end

    finalize
  end

  def initialize
    @lexer = Lexer.new
    @parser = Parser.new
  end

  def compute(expression)
    tokens = @lexer.lex(expression)
    @parser.parse(tokens)
  end
end

# calc = Calculator.new
# puts calc.compute('5 * (2 + 20 / 4)')
# puts calc.compute('5 * (-2 + 20 / 4)')
# puts calc.compute('5 * (--2 + 20 / 4)')
# puts calc.compute('1 + 2 * 3')
# puts calc.compute('1 + pow(2 * 3, 4) * 50 - (4 + 2*5)!')

# puts calc.compute('42 + pow(233, 42) + 42! + (233 + 42) * 233')
