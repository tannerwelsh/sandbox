# algorithm:
# move through each pair of $choices (sorting highest to lowest priority)
# compare the two $choices
# if the first choice is better
#   go to next pair
# if the second choice is better
#   swap the two items
#   flag a swap
#   restart from index of second item

$choices = %w[ apples bananas peaches strawberries ]

def choose(a, b)
  puts "Which would you prefer:",
       "A) " + a,
       "B) " + b, "\n"

  selection = gets.chomp.downcase
end

def sort(start_index, limit_index)
  start_index.upto(limit_index) do |i|
    p $choices
    a, b = $choices[i, 2]

    selection = choose(a, b)

    if selection == 'b'
      $choices[i] = b
      $choices[i + 1] = a
      $swapped = true

      start_index = i + 1

      sort(start_index, limit_index)
      break
    end
  end
end

$swapped = true

while $swapped
  $swapped = false

  sort(0, $choices.length - 2)
end

p $choices
