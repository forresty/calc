# rpn_evaluator.rb
class RPNEvaluator
  def ev(tokens)
    stack = []
    until tokens.empty?
      token = tokens.shift
      case token
      when Integer then stack.push(token) # token is number
      when Symbol
        right = stack.pop
        left  = stack.pop
        stack.push ev_op(left, token, right) # token is op
      end
    end
    stack.pop
  end

  def ev_op(left, op, right)
    case op
    when :* then left * right
    when :/ then left / right
    when :+ then left + right
    when :- then left - right
    end
  end
end
