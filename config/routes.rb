Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'welcome#index'
  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id', to: 'shelters#show'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'
  get '/pets', to: 'pets#index'
  get '/shelters/:id/pets', to: 'shelters#show_pets'
  get '/favorites', to: 'pets#show_favorite'
  delete '/pets/:id/fav', to: 'pets#remove_favorite'
  get '/pets/:id/fav', to: 'pets#add_favorite'
  get '/pets/:id', to: 'pets#show'
  get '/shelters/:id/pets/new', to: 'pets#new'
  post '/pets', to: 'pets#create'
  get '/pets/:id/edit', to: 'pets#edit'
  post '/pets/:id', to: 'pets#update'
  get '/shelters/:id/pets', to: 'pets#edit'
  delete '/pets/:id', to: 'pets#destroy'
  get '/shelters/:id/new', to: 'reviews#new'
  post 'shelters/:id', to: 'reviews#create'
  get '/shelters/:id/:id/edit', to: 'reviews#edit'
  patch '/shelters/:id/:id', to: 'reviews#update'
  delete '/shelters/:id/:id', to: 'reviews#destroy'
end
