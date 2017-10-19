var y = function(x) { return function(y, func) {  } };

function adder(x) { return function(y) { return x + y } }

var addFive = adder(5);

console.log( addFive(6) );
