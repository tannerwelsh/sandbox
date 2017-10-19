def binary_search(array, obj, offset = 0)
  middle_index = array.length / 2
  middle_obj   = array[middle_index]

  if obj == middle_obj
    return middle_index + offset
  elsif obj > middle_obj
    return binary_search(array[middle_index..-1], obj, middle_index + offset)
  elsif obj < middle_obj
    return binary_search(array[0...middle_index], obj, offset)
  end
end

test_array = (1..100).to_a

puts binary_search(test_array, 1)
puts binary_search(test_array, 100)
puts binary_search(test_array, 50)
puts binary_search(test_array, 81)
puts binary_search(test_array, 23)
