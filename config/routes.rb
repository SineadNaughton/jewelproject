Rails.application.routes.draw do
  devise_for :users
  
  resources :items
  root 'static_pages#home'
  
  get '/about' => 'static_pages#about'
  get '/contact' => 'static_pages#contact'
  get '/delivery' => 'static_pages#delivery'
  
    get 'cart/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 #cart routes
  get '/cart' => 'cart#index'
  
  get '/cart/clear' => 'cart#clear'
  get '/cart/:id' => 'cart#add'
  get '/cart/remove/:id' => 'cart#remove'
  get '/cart/updatequantity/:id' => 'cart#update_quantity'
  get '/cart/addbyquantity/:id' => 'cart#add_by_quantity'
  get '/cart/total' => 'cart#cart_header_info'

end
