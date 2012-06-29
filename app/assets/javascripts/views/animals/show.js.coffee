class App.AnimalDetailView extends Backbone.View
  el: '#detail'
  template: JST['templates/animals/show']

  initialize: (options) ->
    @collection.bind 'select:animal', @animalSelected, this

  animalSelected: (animal) ->
    # unbind from the current model
    @model.off(null,null,this) if @model?

    # bind the new model
    @model = animal
    @model.bind 'change', @render
    @render()

  render: =>
    @$el.html @template model:@model.toJSON()
    return this
