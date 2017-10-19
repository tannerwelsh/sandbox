var socket = new WebSocket( "ws://localhost:1234" );

var form = document.getElementById("form"),
    input = document.getElementById("input"),
    output = document.getElementById("output");

function newElement(tag, content) {
  var elem = document.createElement(tag),
      text = document.createTextNode(content);

  elem.appendChild(text);

  return elem;
}

socket.onmessage = function(event) {
  console.log('Message received: ' + event.data);

  var msg = newElement('p', event.data);
  output.appendChild(msg);
};

form.onsubmit = function(event) {
  event.preventDefault();
  socket.send( input.value );
};
