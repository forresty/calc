# shunting_yard.rb
class ShuntingYard
  def build_rpn(tokens)
    output = []
    operators = []

    until tokens.empty?
      token = tokens.shift

      case token
      when Integer then output << token
      when :'('    then operators.push(token)
      when :')'
        while (top = operators.pop) != :'('
          output << top
        end
      when :+, :-
        until operators.empty? || operators[-1] == :'('
          output << operators.pop
        end
        operators.push(token)
      when :*, :/
        while operators.size > 0 && [:*, :/].include?(operators[-1])
          output << operators.pop
        end
        operators.push(token)
      end
    end
    output << operators.pop until operators.empty?

    output
  end
end
