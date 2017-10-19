puts -> {

  # factorial in lambda calculus, using the Y Combinator
  ->(f) {
    f[f]
  }.(
    ->(f) {
      ->(n) { n.zero? ? 1 : n * f[f][n-1] }
    } 
  ).(1)


  #fib = ->(n) {
    #return 0 if n == 1
    #return 1 if n == 2 

    #fib[ n - 2 ] + fib[ n - 1 ]
  #}

  #fib[8]

  # fibonacci using the Y Combinator
  ->(fib) {
    fib[fib] 
  }[
    ->(fib) {
      ->(n) {
        return 0 if n == 1
        return 1 if n == 2 

        fib[fib][ n - 2 ] + fib[fib][ n - 1 ]
      }
    } 
  ][8]

}[]
