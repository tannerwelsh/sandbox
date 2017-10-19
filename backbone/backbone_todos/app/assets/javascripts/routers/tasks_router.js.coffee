class BackboneTodos.Routers.Tasks extends Backbone.Router
  routes:
    '': 'index'

  initialize: ->
    @collection = new BackboneTodos.Collections.Tasks()
    @collection.reset($('#tasks').data('tasks'))

  index: ->
    view = new BackboneTodos.Views.TasksIndex(collection: @collection)
    $('#tasks').html(view.render().el)
