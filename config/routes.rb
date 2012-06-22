ListBone::Application.routes.draw do
  resources :animals

  root :to => 'animals#index'

end
