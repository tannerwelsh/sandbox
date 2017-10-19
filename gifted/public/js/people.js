// Person model

function Person(personObj) {
  if (personObj)
    this.assignAttributes(personObj);
}

Person.prototype.assignAttributes = function(personObj) {
  var self = this;

  self.attributes.forEach(function(attrName) {
    if (personObj[attrName])
      self[attrName] = personObj[attrName];
  });
};

Person.prototype.attributes = ['name', 'birthday', 'email', 'phone', 'address', 'city', 'zip_code', 'state', 'country'];

Person.all = (function() {
  var people = [];

  return function(callback) {
    if (people.length === 0)
      people = Person._fetch(callback);

    return people;
  }
})();

Person.prototype.save = function(callbacks) {
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

  req.open('post', '/people', true);
  req.responseType = 'json';
  req.setRequestHeader("Content-Type", "application/json");
  req.send(self._serialize());

  return self;
}

Person._fetch = function(callback) {
  var self = this
    , req = new XMLHttpRequest();

  if (callback) {
    req.addEventListener('load', function(evt) {
      /*
        Execute the callback function with:
        - `this` bound to the `Person` function
        - first argument a collection of parsed Person objects
      */
      return callback.call(self, self._deserialize(evt.target.response));
    });
  }

  req.open('get', '/people', true);
  req.responseType = 'json';
  req.send();

  return req.response;
};

Person._deserialize = function(jsonArray) {
  var people = [];

  jsonArray.forEach(function(personObj) {
    people.push( new Person(personObj) );
  });

  return people;
};

Person.prototype._serialize = function() {
  var self = this
    , serializedObj = {};

  self.attributes.forEach(function(attrName) {
    if (self[attrName])
      serializedObj[attrName] = self[attrName];
  });

  return JSON.stringify(serializedObj);
};
