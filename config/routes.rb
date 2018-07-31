Rails.application.routes.draw do
  get 'wishlistitems/add'
  get 'wishlistitems/remove'
  get 'wishlistitems/index'
  #orders routes
  resources :orders do
    resources:orderitems
  end
  
  
  #user routes
  devise_for :users do
    resources:orders
  end
  devise_for :controllers => {
   :registration => "users/registration",
    :sessions => "users/sessions",
    :passwords => "users/passwords",
    :confirmation => "users/confriamtions" }
  devise_scope :users do
    get 'signup', to: 'users/regisatrations#new'
    get 'signin', to: 'users/session#new'
    delete 'signout', to: 'users/session#destroy'
  end
  
  post '/search' => 'items#search'
  get '/search' => 'items#search'
  post '/filter' => 'items#filter'
  get '/filter' => 'items#filter'
  
  resources :items do
    resources :reviews
  end
  
  get '/items/bestselling' => 'items#bestselling'
  
  
  #static page roots
  root 'static_pages#home'
  
  get '/about' => 'static_pages#about'
  get '/contact' => 'static_pages#contact'
  get '/delivery' => 'static_pages#delivery'
 
  
  #cart routes
    get 'cart/index'
 
  get '/cart' => 'cart#index'
  
  get '/cart/clear' => 'cart#clear'
  get '/cart/:id' => 'cart#add'
  get '/cart/remove/:id' => 'cart#remove'
  get '/cart/updatequantity/:id' => 'cart#update_quantity'
  get '/cart/addbyquantity/:id' => 'cart#add_by_quantity'
 # get '/cart/total' => 'cart#cart_header_info'
  get '/checkout' => 'cart#index'
  post '/checkout' => 'cart#create_order'
  
 #get '/useraccount/userorder/:id' => 'useraccount#ordershow'
  get '/useraccount/welcome' => 'useraccount#welcome'
  get '/useraccount/userorders' => 'useraccount#userorders'
  get '/admin' => 'useraccount#admin_welcome'
  get 'users' => 'useraccount#admin_users'
  get '/useraccount/reviews' => 'useraccount#user_reviews'
  
  post '/wishlist/add/:id' => 'wishlistitems#add'
  get '/wishlist/add/:id' => 'wishlistitems#add'
  get '/wishlist' => 'wishlistitems#index'
  delete '/wishlist/:id' => 'wishlistitems#destroy'
  
  get '/payment' => 'orders#pay'
  post '/payment' => 'orders#pay'

  get '/shipped/:id' => 'orders#shipped'
  



 
 # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end
