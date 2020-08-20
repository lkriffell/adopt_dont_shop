Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id', to: 'shelters#show'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters', to: 'shelters#update'
  get '/shelters/:id/delete', to: 'shelters#destroy'
  get '/pets', to: 'pets#index'
  get '/shelters/:id/pets', to: 'shelters#show_pets'
  get 'pets/:id', to: 'pets#show'
  get '/shelters/:id/pets/new', to: 'pets#new'
  post '/pets', to: 'pets#create'
  get '/pets/:id/edit', to: 'pets#edit'
  post '/pets/:id', to: 'pets#update'
  get '/shelters/:id/pets', to: 'pets#edit'
  get '/pets/:id/delete', to: 'pets#destroy'
end
