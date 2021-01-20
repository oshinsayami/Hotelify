Rails.application.routes.draw do
  get '/' => 'sessions#welcome'
  get '/auth/google_oauth2/callback' => 'sessions#omniauth'  
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  delete '/logout' => 'sessions#destroy'
 
  resources :ratings
  resources :hotels do 
     resources :ratings, only: [:new, :index]
  end
  resources :locations
  resources :users

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
