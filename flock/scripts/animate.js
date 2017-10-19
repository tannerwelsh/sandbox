var Animate = {
  run: function() {
    var canvas = document.getElementById('field');

    // Make canvas as big as the window
    canvas.width = screen.width;
    canvas.height = screen.height;

    var context = canvas.getContext("2d");

    var flock = new Flock(context);

    flock.populate(100);

    setInterval(function() {
      Animate.draw(flock, context);
      Animate.step(flock, context);
    }, 34);
  }
  , draw: function(flock, context) {
    // Clear canvas
    context.clearRect(0, 0, context.canvas.width, context.canvas.height);

    flock.drawAll();
  }
  , step: function(flock, context) {
    flock.moveAll();
  }
};

// Bind to load event of body
document.body.onload = Animate.run;
