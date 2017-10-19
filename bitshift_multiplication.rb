a, b = ARGV.map(&:to_i)

c = 0

while b != 0
  if b & 1 != 0
    c += a
  end
  a = a << 1
  b = b >> 1
  p "a: #{a}, b: #{b}, c: #{c}"
end

p c
