# domain_specific_calc.rb
require_relative 'lexer'
require_relative 'shunting_yard'
require_relative 'rpn_evaluator'

class Calculator
  def initialize
    @lexer = Lexer.new
    @yard = ShuntingYard.new
    @rpn_evaluator = RPNEvaluator.new
  end

  def compute(expression)
    infix_tokens = @lexer.tokenize(expression)
    rpn_tokens = @yard.build_rpn(infix_tokens)
    @rpn_evaluator.ev(rpn_tokens)
  end
end
