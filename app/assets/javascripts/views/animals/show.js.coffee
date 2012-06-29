class App.AnimalDetailView extends Backbone.View
  el: '#detail'
  template: JST['templates/animals/show']

  initialize: (options) ->
    @collection.bind 'select:animal', @animalSelected

  animalSelected: (animal)=>
    # unbind from the current model
    @model.off() if @model?

    # bind the new model
    @model = animal
    @model.bind 'change', @render
    @render()

  render: =>
    @$el.html @template model:@model.toJSON()
    return this
