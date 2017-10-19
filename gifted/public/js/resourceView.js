function ResourceView(resourceName) {
  this.resourceName = resourceName;

  this.listingSelector = '.' + resourceName + '-list';
  this.formSelector = 'form[name=' + resourceName + ']';
  this.inputSelector = 'input[name^="' + resourceName + '"]'
}

ResourceView.prototype.listing = function(elements) {
  var listingElem = document.querySelector(this.listingSelector);

  if (elements) {
    elements.forEach(function(element) {
      listingElem.appendChild(element);
    });
  }

  return listingElem;
};

ResourceView.prototype.form = function() {
  return document.querySelector(this.formSelector);
};

ResourceView.prototype.formData = function() {
  var form = this.form()
    , inputs = form.querySelectorAll(this.inputSelector)
    , resourceObj = {};

  for (var i = inputs.length - 1; i >= 0; i--) {
    var attrName = inputs[i].name.match(/\[(.*)\]/)[1]
      , attrValue = inputs[i].value;

    resourceObj[attrName] = attrValue;
  };

  return resourceObj;
};

ResourceView.prototype.append = function(resource) {
  this.listing().appendChild(this._resourceHTML(resource));
};

ResourceView.prototype.showErrors = function(resource) {
  alert(resource.errors);
};

ResourceView.prototype.showAll = function(resources) {
  var self = this
    , resourcesHTML = [];

  resources.forEach(function(resource) {
    resourcesHTML.push( self._resourceHTML(resource) );
  });

  self.listing(resourcesHTML);
};

ResourceView.prototype._resourceHTML = function(resource) {
  var el = document.createElement('div')
    , html = "";

  el.className = this.resourceName;

  resource.attributes.forEach(function(attrName) {
    if (resource[attrName])
      html += resource[attrName] + '<br>';
  })

  el.innerHTML = html;

  return el;
}
