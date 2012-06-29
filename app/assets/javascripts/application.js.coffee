#= require jquery
#= require jquery_ujs
#= require underscore
#= require backbone

#= require_self
#= require_tree .
#= require_bootstrap

@App ||= {}

$ ->
  animals = new App.AnimalCollection()
  listView = new App.AnimalListView(collection:animals)
  detailView = new App.AnimalDetailView(collection:animals)
  editView = new App.EditAnimalView(collection:animals)

  animals.fetch()