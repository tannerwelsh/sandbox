document.addEventListener('DOMContentLoaded', function(evt) {
  var peopleRouter = new Router(Person, new ResourceView('person'))
    , giftsRouter = new Router(Gift, new ResourceView('gift'))
    , holidaysRouter = new Router(Holiday, new ResourceView('holiday'));
})
