# Original ----------------------

# $*.map{|a|(i=a=~/0/)?(v=*?1..?9).fill{|j|v-=[a[j+i-k=i%9],a[k+j*=9],a[j%26+i-i%3-i%27+k]]}+v.map{|k|$*.<<$`<<k<<$'}:p(a)}


# Expanded ----------------------

# $*.map { |a| 
# 	(i = a =~ /0/) ? (v =* ?1..?9).fill { |j| 
# 		v -= [a[j + i - k = i%9], 
# 					a[k + j *= 9], 
# 					a[j%26 + i - i%3 - i%27 + k]] 
# 	} + v.map { |k| 
# 		$*.<< $` << k << $'
# 	}:p(a)
# }


# Annotated ----------------------

# $*.map { |a| 
# 	(i = a =~ /0/) ? (v =* ?1..?9).fill { |j| 
# 		v -= [a[j + i - k = i%9], 
# 					a[k + j *= 9], 
# 					a[j%26 + i - i%3 - i%27 + k]] 
# 	} + v.map { |k| 
# 		$*.<< $` << k << $'
# 	}:p(a)
# }


# Idiomatic ----------------------

board = Array(ARGV.first)

board.map do |contents|
	if i = (contents =~ /0/)
		v = ('1'..'9').to_a

		v.fill do |j|
			v -= [contents[j + i - k = i%9], 
						contents[k + j *= 9], 
						contents[j%26 + i - i%3 - i%27 + k]] 
		end + \
		v.map do |k| 
			$*.<<$`<<k<< $'
		end

		p(contents)		
	end
end


