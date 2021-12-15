Rails.application.routes.draw do
  get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root :to => 'home#index'
  post '/', :to => 'home#submit'
  post '/submit_trip', :to => 'home#submit_trip'
  get '/admin/login', :to => 'admin#login'
  post '/admin/login', :to => 'admin#login'
  get '/chennai106', :to => 'admin#home'
  get '/tc', :to => 'home#terms_conditions'
  get '/about_us', :to => 'home#about_us'
  get '/pricing', :to => 'home#pricing'
  get '/payment_methods', :to => 'home#payment_methods'
end
