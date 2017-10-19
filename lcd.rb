def lcd(fraction_one, fraction_two)
  # Fractions will come in as a string, i.e. '1/3' and
  # thus must be parsed and converted to integers
  denominators = []
  denominators << fraction_one.split('/').last.to_i
  denominators << fraction_two.split('/').last.to_i

  if denominators.first == denominators.last
    return denominators.first
  end

  a = denominators.max
  b = denominators.min

  # Starting with 1
  multiplier = 1
  loop do
    multiple = a * multiplier

    if multiple % b == 0
      return multiple
    else
      multiplier += 1
    end
  end
end

puts lcd('1/2', '3/8')
puts lcd('7/10', '2/3')
puts lcd('4/9', '11/12')


def lcd_for_many(*fractions)
  raise "Must provide at least two fractions." if fractions.count < 2

  if fractions.count == 2
    lcd(fractions.first, fractions.last).to_s
  else
    lcd_for_many(fractions[0], lcd_for_many(*fractions[1..-1]))
  end
end

puts lcd_for_many('1/2', '2/3', '3/8')
puts lcd_for_many('3/4', '9/10', '2/7')
puts lcd_for_many('15/28', '3/14', '9/16', '31/32', '3/22')
puts lcd_for_many('12/31', '48/321', '182/1023', '23/11')
