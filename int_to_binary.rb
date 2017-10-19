class Integer
  def to_binary(bin_str = '')
    if self == 0
      return bin_str
    else
      d, r = divmod(2)
      d.to_binary(bin_str) + r.to_s
    end
  end
end

class String
  def binary_to_integer
    if empty?
      return 0
    else
      factor = self.length - 1
      self[0...factor].binary_to_integer + (self[factor] == '1' ? 2 ** factor : 0)
    end
  end
end

p 0.to_binary # how to get this case to work?
p 1.to_binary.binary_to_integer
p 4.to_binary
p 6.to_binary
p 9.to_binary
p 13.to_binary
p 119.to_binary
p 107
p 107.to_binary
p 119.to_binary.binary_to_integer
p 238.to_binary
p 65535.to_binary
