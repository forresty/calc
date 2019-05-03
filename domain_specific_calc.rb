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

# def run_test
#   yield
#   puts
#   puts
#   puts 'all tests passed.'
# end

# def assert_equals(expected, actual)
#   unless expected == actual
#     raise "expected: #{expected.inspect}, got #{actual}"
#   end
#   print '.'
# end

# run_test do
#   calc = Calculator.new
#   assert_equals 12, calc.compute('1 + 11')
#   assert_equals 34, calc.compute('1 + 11 * 3')
#   assert_equals 36, calc.compute('(1 + 11) * 3')
#   assert_equals 30, calc.compute('(20 / 2) * 3')
#   assert_equals 5, calc.compute('30 / (2 * 3)')
#   assert_equals 180, calc.compute('30 / 2 * (2 * 3) * 2')
#   assert_equals 951062, calc.compute('(((6 + 422534 * 3) / 2 + 233) * 3 + 13) / 2')
# end
