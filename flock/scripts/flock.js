function Flock(context) {
  this.context = context;
  this.drones = [];
};

Flock.prototype.populate = function(num) {
  var self = this;

  _.times(num, function(i) {
    var coords = randCoords(),
        x = coords.x,
        y = coords.y;

    self.drones.push(new Drone(x, y, self.context, self));
  })

  return self;
};

Flock.prototype.drawAll = function() {
  var self = this;

  _.each(self.drones, function(drone, index, list) {
    drone.draw();
  });

  return self;
};

Flock.prototype.moveAll = function() {
  var self = this;

  _.each(self.drones, function(drone, index, list) {
    var neighbors = drone.neighbors(self.drones),
        bearingShift = randRadians(Math.PI / 36);

    if ( neighbors ) {
      // Change bearing in direction of neighbor
      if (neighbors[1].bearing > drone.bearing) {
        drone.bearing += Math.abs(bearingShift);
      }
      else {
        drone.bearing -= Math.abs(bearingShift);
      }
    }
    else {
      // Randomly veer +/- 0-5 degrees
      drone.bearing += bearingShift;
    }

    if ( drone.x < 0 )
      drone.x = self.context.canvas.width;
    if ( drone.x > self.context.canvas.width )
      drone.x = 0;
    if ( drone.y < 0 )
      drone.y = self.context.canvas.height;
    if ( drone.y > self.context.canvas.height)
      drone.y = 0;

    drone.move();
  })
};

function randCoords() {
  var x = Math.floor(Math.random() * screen.width);
  var y = Math.floor(Math.random() * screen.height);

  return {x: x, y: y};
}

function randRadians(range) {
  return Math.random() * range * (Math.round(Math.random()) * 2 - 1);
}
