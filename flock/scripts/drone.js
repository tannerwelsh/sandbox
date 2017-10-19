function Drone(x, y, context, flock) {
  this.x = x;
  this.y = y;
  this.context = context;
  this.flock = flock;

  this.size = 9;
  this.bearing = Math.random() * (Math.PI * 2) // Bearing in radians
};

Drone.prototype.draw = function() {
  if ( this.neighbors() ) {
    // Make drones with neighbors red
    this.context.fillStyle = "rgba(255,0,0,1)";
  }
  else {
    // Make drones without neighbors blue
    this.context.fillStyle = "rgba(0,0,255,1)";
  }

  this.context.fillRect(this.x - (this.size / 2), this.y - (this.size / 2), this.size, this.size);

  var coordinateDelta = this.coordinateDelta(),
      xDelta = coordinateDelta[0] * this.size - 1,
      yDelta = coordinateDelta[1] * this.size - 1;

  this.context.fillRect(this.x + xDelta, this.y + yDelta, 3, 3)
};

Drone.prototype.move = function() {
  var coordinateDelta = this.coordinateDelta(),
      xDelta = coordinateDelta[0],
      yDelta = coordinateDelta[1];

  this.x += xDelta;
  this.y += yDelta;
};

Drone.prototype.coordinateDelta = function() {
  // Returns an [x, y] pair of integers representing the change
  // in coordinates between this and the next step.
  var velocity = 2,
      xDelta = velocity * Math.sin(this.bearing),
      yDelta = velocity * Math.cos(this.bearing);

  return [xDelta, yDelta];
};

Drone.prototype.neighbors = function() {
  var boundingBox = this.boundingBox(),
      drones = this.flock.drones;

  var neighbors = _.filter(drones, function(d) {
    return d.inBox(boundingBox);
  });

  if (neighbors.length > 1) {
    return neighbors;
  }
  else {
    return false;
  }
};

Drone.prototype.boundingBox = function() {
  var boxRadius = this.size * 4;

  // Returns the bounding box for this drone in the format
  // [<top left x>, <top left y>, <bottom right x>, <bottom right y>]
  return [  (this.x - boxRadius)
          , (this.y - boxRadius)
          , (this.x + boxRadius)
          , (this.y + boxRadius)
         ]
};

Drone.prototype.inBox = function(boundingBox) {
  return (this.x > boundingBox[0] && this.x < boundingBox[2])
      && (this.y > boundingBox[1] && this.y < boundingBox[3]);
};
