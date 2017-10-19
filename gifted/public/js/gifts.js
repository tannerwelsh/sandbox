// Gift model

function Gift(giftObj) {
  if (giftObj)
    this.assignAttributes(giftObj);
}

Gift.prototype.assignAttributes = function(giftObj) {
  var self = this;

  self.attributes.forEach(function(attrName) {
    if (giftObj[attrName])
      self[attrName] = giftObj[attrName];
  });
};

Gift.prototype.attributes = ['name', 'price', 'category'];

Gift.all = (function() {
  var gifts = [];

  return function(callback) {
    if (gifts.length === 0)
      gifts = Gift._fetch(callback);

    return gifts;
  }
})();

Gift.prototype.save = function(callbacks) {
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

  req.open('post', '/gifts', true);
  req.responseType = 'json';
  req.setRequestHeader("Content-Type", "application/json");
  req.send(self._serialize());

  return self;
}

Gift._fetch = function(callback) {
  var self = this
    , req = new XMLHttpRequest();

  if (callback) {
    req.addEventListener('load', function(evt) {
      /*
        Execute the callback function with:
        - `this` bound to the `Gift` function
        - first argument a collection of parsed Gift objects
      */
      return callback.call(self, self._deserialize(evt.target.response));
    });
  }

  req.open('get', '/gifts', true);
  req.responseType = 'json';
  req.send();

  return req.response;
};

Gift._deserialize = function(jsonArray) {
  var gifts = [];

  jsonArray.forEach(function(giftObj) {
    gifts.push( new Gift(giftObj) );
  });

  return gifts;
};

Gift.prototype._serialize = function() {
  var self = this
    , serializedObj = {};

  self.attributes.forEach(function(attrName) {
    if (self[attrName])
      serializedObj[attrName] = self[attrName];
  });

  return JSON.stringify(serializedObj);
};
