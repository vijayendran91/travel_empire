Rails.application.routes.draw do
  get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root :to => 'home#index'
  post '/', :to => 'home#submit'
  post '/submit_trip', :to => 'home#submit_trip'
  get '/chennai106', :to => 'admin#home'
  get '/tc', :to => 'home#terms_conditions'
  get '/about_us', :to => 'home#about_us'
  get '/pricing', :to => 'home#pricing'
  get '/payment_methods', :to => 'home#payment_methods'
  get '/contact_us', :to => 'home#contact_us'

  post '/wa/wh/receive_msg', :to => 'whatsapp#receive_msg'

  post '/chennai106', :to => 'admin#home', :format => 'xlsx'
  get '/chennai106', :to => 'admin#home', :format => 'html'
  get '/admin_login', :to => 'admin#login'
  get 'admin/trip_details/', :to => 'admin#trip_details'
  get 'admin/edit_trip/', :to => 'admin#edit_trip'
  put 'admin/edit_trip/', :to => 'admin#edit_trip'
  delete 'admin/cancel_trip', :to => 'admin#cancel_trip'
  get '/admin/wa_index', :to => 'whatsapp#wa_index'
  get '/admin/wa_messenger', :to => 'whatsapp#wa_messenger'
  post 'admin/wa_messenger', :to => 'whatsapp#wa_messenger'

  post '/admin_login', :to => 'sessions#login'
  delete '/admin_logout', :to => 'sessions#logout'

  get 'trip/status', :to => 'trip#status'
  get ':id/driver_module', :to => 'driver_module#trip_start', :as=> 'trip_start'
  post ':id/driver_module', :to => 'driver_module#trip_start', :as => 'trip_start_submit'
end
