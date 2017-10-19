function Router(model, view) {
  this.model = model;
  this.view = view;

  this.activate();
}

Router.prototype.activate = function() {
  var self = this;

  self.model.all(self.view.showAll.bind(self.view));

  self.view.form().addEventListener('submit', self.sendFormData);
};

Router.prototype.sendFormData = function(evt) {
  evt.preventDefault();

  var holidayData = self.view.formData()
    , holiday = new self.model(holidayData);

  holiday.save({
    success: self.view.append.bind(self.view)
  , error: self.view.showErrors.bind(self.view)
  })
};
