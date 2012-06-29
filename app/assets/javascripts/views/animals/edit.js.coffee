class App.EditAnimalView extends Backbone.View
  ENTER = 13

  el: '#edit'
  template: JST['templates/animals/edit']

  events:
    'change #hair_checkbox': 'toggleHairy'
    'keypress input[name="name"]' : 'changeName'

  initialize: (options) ->
    @collection.bind 'select:animal', @animalSelected

  animalSelected: (animal)=>
    # unbind from the current model
    @model.off() if @model?

    # bind the new model
    @model = animal
    @model.bind 'change', @onChange
    @render()

  render: =>
    @$el.html @template model:@model.toJSON()
    return this

  toggleHairy: (e) =>
    @model.set hair:e.target.checked
    @model.save()

  changeName: (e) =>
    keyCode = e.keyCode || e.which
    if keyCode == ENTER
      @model.set name:$(e.target).val()
      @model.save()
