class App.AnimalListView extends Backbone.View
  el: '#animals'
  template: JST['templates/animals/index']

  initialize: (options) ->
    @collection.bind 'reset', @addAll
    @collection.bind 'add', @addOne

    # TODO can't select more than once.
    @collection.bind 'select:animal', @select, this

  addAll: =>
    @$el.html @template model:@collection.toJSON()
    @$el.find('#list').append @collection.map @addOne

  addOne: (animal) =>
    view = new App.AnimalView model:animal
    view.render().el

  select: () ->
    @$el.find('li').toggleClass('selected',false)

class App.AnimalView extends Backbone.View
  tagName: 'li'
  templateName: 'templates/animals/animal'

  events:
    'click': 'select'

  initialize: ->
    @model.bind 'change', @render, this

  select: (e) =>
    @model.collection.trigger 'select:animal', @model
    @$el.toggleClass('selected',true)

  render: ->
    console.log 'render', @model.get('name')
    @$el.html JST[@templateName] model:@model.toJSON()
    return this
