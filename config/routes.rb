Rails.application.routes.draw do
  resources :passengers, except: [:update]
  patch '/passengers/:id', to: 'passengers#update'
  
  resources :drivers, except: [:update]
  patch '/drivers/:id', to: 'drivers#update'
  
  resources :trips, except: [:update, :index, :new, :create]
  patch '/trips/:id', to: 'trips#update'
  get '/trips/:id/assign_rating/edit', to: 'trips#assign_rating_edit', as: 'assign_rating_edit'
  # patch '/trips/:id/assign_rating', to: 'trips#assign_rating', as: 'assign_rating'
end
