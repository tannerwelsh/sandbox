# Setup an array of randomly sorted numbers

@numbers = (1..1_000_000).to_a.shuffle
@numbers.delete_at(rand(1_000_000))

def sort_find
  sorted = @numbers.sort
  sorted.each_with_index do |n, i|
    next if n == sorted[i-1] + 1 || n == 0
    return n-1
  end
end

def inject_find
  (1..1_000_000).inject(&:+) - @numbers.inject(&:+)
end

def new_array_find
  new_array = [] # Array.new(1_000_000)
  @numbers.each { |n| new_array[n-1] = n }
  new_array.index(nil) + 1
end

t1 = Time.now
sort_find
t2 = Time.now
p "Time to execute sort_find: #{t2 - t1}"
p "Found the missing number: #{@numbers.index(sort_find) == nil}"

t3 = Time.now
inject_find
t4 = Time.now
p "Time to execute inject_find: #{t4 - t3}"
p "Found the missing number: #{@numbers.index(inject_find) == nil}"

t5 = Time.now
new_array_find
t6 = Time.now
p "Time to execute new_array_find: #{t6 - t5}"
p "Found the missing number: #{@numbers.index(new_array_find) == nil}"

case [(t6-t5),(t4-t3),(t2-t1)].min
when t2-t1 then fastest = :sort_find
when t4-t3 then fastest = :inject_find
when t6-t5 then fastest = :new_array_find
end

p "-----------------\nFASTEST METHOD: #{fastest}"
