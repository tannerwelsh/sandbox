var editor = document.getElementsByName('tint-editor')[0],
  screen = document.getElementById('output');
  
var tintInterpreter = function() {
  evalLoop(function() {
    var code = readCode();

    printOutput(eval(code));
  });
}

var readCode = function() {
  return editor.value;
}

var printOutput = function(output) {
  screen.innerText = output;
}

var evalLoop = function(func) {
  editor.onkeypress = func; 
}


document.addEventListener('DOMContentLoaded', tintInterpreter)
