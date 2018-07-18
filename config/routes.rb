Rails.application.routes.draw do
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
  
  
  resources :items
  
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
  get '/cart/total' => 'cart#cart_header_info'
  get '/checkout' => 'cart#create_order'
 # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 
end
