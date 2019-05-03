# ripper_calc.rb
require 'ripper'
require 'pp'

class Calculator
  def compute(expression)
    tree = Ripper.sexp(expression)

    ev(tree[-1][0]) # only take first expression in the program body
  end

  private

  def ev(node)
    type, _ = node
    case type
    when :unary  then ev_unary(node)
    when :binary then ev_binary(node)
    when :paren  then ev(node[-1][0]) # ev the child of `paren` node
    when :@int   then node[1].to_i
    end
  end

  def ev_binary(node)
    _, left, op, right = node
    case op
    when :* then ev(left) * ev(right)
    when :/ then ev(left) / ev(right)
    when :+ then ev(left) + ev(right)
    when :- then ev(left) - ev(right)
    end
  end

  def ev_unary(node)
    _, op, child = node
    case op
    when :+@ then ev(child)
    when :-@ then -ev(child)
    end
  end
end
