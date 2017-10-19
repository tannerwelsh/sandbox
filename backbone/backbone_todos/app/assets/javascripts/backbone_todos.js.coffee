window.BackboneTodos =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    new BackboneTodos.Routers.Tasks()
    Backbone.history.start()

$(document).ready ->
  BackboneTodos.initialize()
