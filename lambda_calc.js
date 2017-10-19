//function fact(x) {
  //return x === 0 ? 1 : x * fact(x - 1);
//}

console.log(

  // factorial using the Y Combinator
  function(f) {
    return f(f)
  }(
    function(f) {
      return function(n) {
        console.log("inner function call for " + n);
        return n === 0 ? 1 : n * f(f)(n-1)
      }
    }
  )(5),

  // string reversal using the Y Combinator
  function(f) {
    return f(f)
  }(
    function(f) {
      return function(str) {
        if ( str.length == 1 ) {
          return str
        } else {
          return str[str.length - 1] + f(f)(str.slice(0, str.length - 1))
        }
      }
    }
  )("foobar")

)
