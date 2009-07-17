ActionController::Routing::Routes.draw do |map|
  map.resources :managers
  map.resources :weeks
  map.resources :projects
  map.resources :engineers
  map.resources :assignments

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
