Array.prototype.flatten = function() {
  for (var i = 0; i < this.length; i++) {
  }
}

var TreeNode = function(value) {
  this.value = value;
  this.children = [];
};

TreeNode.prototype.addChild = function(node) {
  this.children.push(node);
};

TreeNode.prototype.eachChild = function(callback) {
  for (var i = 0; i < this.children.length; i++) {
    callback(this.children[i]);
    this.children[i].eachChild(callback);
  }
};

TreeNode.prototype.find = function(value) {
  var target;
  if (this.value == value) {
    target = this;
  } else if (this.children.length > 0) {
    this.eachChild(function(node) {
      var found = node.find(value);
      if (found) { target = found }
    });
  } else {
    return false;
  }
  return target;
};

TreeNode.prototype.findAll = function(value) {
  var targets = [];
  if (this.value == value) {
    targets.push(this);
  }
  if (this.children.length > 0) {
    this.eachChild(function(node) {
      var found = node.findAll(value);
      if (found.length > 0) { targets.push(found) }
    });
  }
  return targets.flatten();
};

var taxonomy = new TreeNode('Animal'),
    reptile = new TreeNode('Reptile'),
    insect = new TreeNode('Insect');

taxonomy.addChild(reptile);
taxonomy.addChild(insect);

reptile.addChild(new TreeNode('Snake'));
insect.addChild(reptile);

//console.log(taxonomy);
//console.log(taxonomy.find('Snake'));

console.log(taxonomy.findAll('Reptile'));
