Rails.application.routes.draw do
  resources :drivers, except: [:update]
  patch '/drivers/:id', to: 'drivers#update'
  put '/drivers/:id/active', to: 'drivers#toggle_active', as: 'toggle_active'
  
  resources :passengers, except: [:update] do
    resources :trips, only: [:create]
  end
  
  patch '/passengers/:id', to: 'passengers#update'
  
  resources :trips, except: [:update, :index, :new, :create]
  patch '/trips/:id', to: 'trips#update'
  get '/trips/:id/assign_rating/edit', to: 'trips#assign_rating_edit', as: 'assign_rating_edit'
  patch '/trips/:id/assign_rating', to: 'trips#assign_rating_update', as: 'assign_rating'
  
  root 'homepages#index'
  get '/homepages', to: 'homepages#index', as: 'homepages'
end
