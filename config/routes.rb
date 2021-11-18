Rails.application.routes.draw do
  get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root :to => 'home#index'
  post '/', :to => 'home#submit'
  post '/submit_trip', :to => 'home#submit_trip'
  get '/chennai106', :to => 'admin#home'
end
