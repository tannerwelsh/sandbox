function Resource(resourceObj) {
  if (resourceObj)
    this.assignAttributes(resourceObj);
}

Resource.define = function(resourceName, url) {
  var resourceType = function(resourceObj) {
    Resource.call(this, resourceObj);
  }

  resourceType.name = resourceName;
  resourceType.url = url;

  resourceType.__proto__ = Resource;

  resourceType.prototype = Object.create(Resource.prototype);
  resourceType.prototype.constructor = resourceType;

  return resourceType;
}

Resource.prototype.assignAttributes = function(resourceObj) {
  var self = this;

  if (!self.attributes)
    debugger; throw "Must define attributes for a resource"

  self.attributes.forEach(function(attrName) {
    if (resourceObj[attrName])
      self[attrName] = resourceObj[attrName];
  });
};

Resource.all = (function() {
  var resources = [];

  return function(callback) {
    if (resources.length === 0)
      resources = this._fetch(callback);

    return resources;
  }
})();

Resource.prototype.save = function(callbacks) {
  var self = this
    , req = new XMLHttpRequest();

  req.addEventListener('load', function(evt) {
    // Handle errors in response
    if (evt.target.status >= 400) {
      self.saved = false;
      self.errors = evt.target.response;

      if (callbacks.error)
        callbacks.error(self.errors)
    }
    else {
      self.saved = true;

      if (callbacks.success)
        callbacks.success(self)
    }
  });

  req.open('post', self.constructor.url, true);
  req.responseType = 'json';
  req.setRequestHeader("Content-Type", "application/json");
  req.send(self._serialize());

  return self;
}

Resource._fetch = function(callback) {
  var self = this
    , req = new XMLHttpRequest();

  if (callback) {
    req.addEventListener('load', function(evt) {
      /*
        Execute the callback function with:
        - `this` bound to the `Resource` function
        - first argument a collection of parsed Resource objects
      */
      return callback.call(self, self._deserialize(evt.target.response));
    });
  }

  req.open('get', self.url, true);
  req.responseType = 'json';
  req.send();

  return req.response;
};

Resource._deserialize = function(jsonArray) {
  var resources = [];

  jsonArray.forEach(function(resourceObj) {
    resources.push( new Resource(resourceObj) );
  });

  return resources;
};

Resource.prototype._serialize = function() {
  var self = this
    , serializedObj = {};

  self.attributes.forEach(function(attrName) {
    if (self[attrName])
      serializedObj[attrName] = self[attrName];
  });

  return JSON.stringify(serializedObj);
};
