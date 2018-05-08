Rails.application.routes.draw do

  devise_for :users
  resources  :users
  
  root 'pages#home'
  get  'users/show'  
  get  'pages/home'
  get  'pages/about'
  get  'pages/delivery'
  get  'cart' => 'cart#index'
  get  'cart/clear' => 'cart#clearCart'
  get  'cart/:id' => 'cart#add'
  post 'cart/increase/:id' => 'cart#increase', as: 'cart_increase'
  post 'cart/reduce/:id' => 'cart#reduce', as: 'cart_reduce'
  delete 'cart/remove/:id' => 'cart#remove', as: 'cart_remove'
  post 'checkout' => 'cart#checkout', as: 'checkout'

  resources :products do
  	resources :reviews
  end 

  #resources :products do
    #resources :cart
  #end 
   
end
