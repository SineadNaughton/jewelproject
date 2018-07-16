Rails.application.routes.draw do
  get 'cart/index'
  resources :items
  root 'static_pages#home'
  
  get '/about' => 'static_pages#about'
  get '/contact' => 'static_pages#contact'
  get '/delivery' => 'static_pages#delivery'
  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 #cart routes
  get '/cart' => 'cart#index'
  
  get '/cart/clear' => 'cart#clear'
  get '/cart/:id' => 'cart#add'
  get '/cart/remove/:id' => 'cart#remove'
end
