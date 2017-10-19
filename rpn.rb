class RPNCalculator
  def evaluate(expression)
    ops      = expression.split
    operands = []

    ops.each do |op|
      if is_operand? op
        operands << op.to_i
      elsif is_operator? op
        a, b = operands.pop(2)
        operands << calculate(a, b, op)
      end
    end

    return operands.last
  end

  def calculate(a, b, operator)
    case operator
    when '+'
      a + b
    when '-'
      a - b
    when '*'
      a * b
    end
  end

  def is_operand?(op)
    op =~ /\d+/
  end

  def is_operator?(op)
    op =~ /[\+\-\*]/
  end
end

calc = RPNCalculator.new

puts calc.evaluate('1 2 +')   # => 3
puts calc.evaluate('2 5 *')   # => 10
puts calc.evaluate('50 20 -') # => 30

# The general rule is that 'A B op' is the same as 'A op B'
# # i.e., 5 4 - is 5 - 4.
puts calc.evaluate('70 10 4 + 5 * -') # => 0
