class Goldbach
  class << self
    def disprove_conjecture
      composites.each do |composite|
        if sum_of_prime_and_twice_square?(composite)
          next
        else
          return composite
        end
      end
    end

    def sum_of_prime_and_twice_square?(number)
      primes_upto(number).any? do |prime|
        is_square?( (number - prime) / 2 )
      end
    end

    def composites
      return to_enum(__callee__) unless block_given?

      n = 1
      loop do
        if n.odd? && !is_prime?(n)
          yield n
        end
        n += 1
      end
    end

    def primes_upto(number)
      if @primes.nil?
        @primes = [2]
      elsif @primes.last >= number
        @primes = nil
        return @primes = primes_upto(number)
      end
      @primes += primes_in( (@primes.last + 1)..number )
    end

    def primes_in(range)
      range.select { |number| is_prime?(number) }
    end

    def is_prime?(number)
      (number - 1).downto(2).all? { |factor| number % factor != 0 }
    end

    def is_square?(number)
      sqrt = Math.sqrt(number)
      sqrt % 1 == 0
    end
  end
end

p Goldbach.disprove_conjecture
