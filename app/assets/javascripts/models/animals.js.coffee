class App.Animal extends Backbone.Model
  urlRoot: '/animals'

class App.AnimalCollection extends Backbone.Collection
  url: '/animals'
  model: App.Animal
