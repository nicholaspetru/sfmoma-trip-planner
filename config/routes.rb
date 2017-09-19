Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'artist/:id/artwork' => 'artist#show_artworks'

  resources :artwork
  resources :artist
  resources :slugs
  resources :users
  resources :interests
  get '/interests' => 'interests#index'
  post '/users/:id' => 'users#mail_interests'
  get '/users/:id' => 'users#show'
  post '/interests/new' => 'interests#create_interest'
  post '/users/new' => 'users#create'
  get '/slugs' => 'slug#index'
  root to: 'interests#index'
end
