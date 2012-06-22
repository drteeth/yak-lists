$ ->
  class Animal extends Backbone.Model
    urlRoot: '/animals'

  class AnimalCollection extends Backbone.Collection
    url: '/animals'
    model: Animal

  class AnimalListView extends Backbone.View
    el: '#list'

    initialize: (options) ->
      @collection.bind 'reset', @addAll
      @collection.bind 'add', @addOne

    addAll: =>
      @$el.empty()
      @collection.each @addOne

    addOne: (animal) =>
      view = new AnimalItemView model:animal
      @$el.append view.render().el

  class AnimalItemView extends Backbone.View
    tagName: 'li'
    templateName: 'animal_list'

    events:
      'click': 'select'

    select: (e) =>
      @model.collection.trigger 'select:animal', @model

    render: ->
      @$el.html JST[@templateName] model:@model.toJSON()
      return this


  class AnimalDetailView extends Backbone.View
    el: '#detail'
    template: JST['animal_detail']

    events:
      'change #hair_checkbox': 'toggleHairy'

    initialize: (options) ->
      @collection.bind 'select:animal', @animalSelected

    animalSelected: (animal)=>
      # unbind from the current model
      if @model?
        @model.off()
        @$el.off 'change'

      # bind the new model
      @model = animal
      @model.bind 'change', @render
      @render()

    render: =>
      @$el.html @template model:@model.toJSON()
      return this

    toggleHairy: (e) =>
      e.preventDefault()
      @model.set hair:e.target.checked

  animals = new AnimalCollection()

  listView = new AnimalListView(collection:animals)
  detailView = new AnimalDetailView(collection:animals)

  # listView.render()
  # detailView.render()

  animals.fetch()