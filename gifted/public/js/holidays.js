var Holiday = Resource.define('Holiday', '/holidays');

Holiday.prototype.attributes = ['name', 'month', 'day'];

// Holiday model

// function Holiday(holidayObj) {
//   if (holidayObj)
//     this.assignAttributes(holidayObj);
// }

// Holiday.prototype.assignAttributes = function(holidayObj) {
//   var self = this;

//   self.attributes.forEach(function(attrName) {
//     if (holidayObj[attrName])
//       self[attrName] = holidayObj[attrName];
//   });
// };

// Holiday.prototype.attributes = ['name', 'month', 'day'];

// Holiday.all = (function() {
//   var holidays = [];

//   return function(callback) {
//     if (holidays.length === 0)
//       holidays = Holiday._fetch(callback);

//     return holidays;
//   }
// })();

// Holiday.prototype.save = function(callbacks) {
//   var self = this
//     , req = new XMLHttpRequest();

//   req.addEventListener('load', function(evt) {
//     // Handle errors in response
//     if (evt.target.status >= 400) {
//       self.saved = false;
//       self.errors = evt.target.response;

//       if (callbacks.error)
//         callbacks.error(self.errors)
//     }
//     else {
//       self.saved = true;

//       if (callbacks.success)
//         callbacks.success(self)
//     }
//   });

//   req.open('post', '/holidays', true);
//   req.responseType = 'json';
//   req.setRequestHeader("Content-Type", "application/json");
//   req.send(self._serialize());

//   return self;
// }

// Holiday._fetch = function(callback) {
//   var self = this
//     , req = new XMLHttpRequest();

//   if (callback) {
//     req.addEventListener('load', function(evt) {
//       /*
//         Execute the callback function with:
//         - `this` bound to the `Holiday` function
//         - first argument a collection of parsed Holiday objects
//       */
//       return callback.call(self, self._deserialize(evt.target.response));
//     });
//   }

//   req.open('get', '/holidays', true);
//   req.responseType = 'json';
//   req.send();

//   return req.response;
// };

// Holiday._deserialize = function(jsonArray) {
//   var holidays = [];

//   jsonArray.forEach(function(holidayObj) {
//     holidays.push( new Holiday(holidayObj) );
//   });

//   return holidays;
// };

// Holiday.prototype._serialize = function() {
//   var self = this
//     , serializedObj = {};

//   self.attributes.forEach(function(attrName) {
//     if (self[attrName])
//       serializedObj[attrName] = self[attrName];
//   });

//   return JSON.stringify(serializedObj);
// };
