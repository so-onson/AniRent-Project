Rails.application.routes.draw do

 

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    get 'session/login'
    post 'session/signup'
    get 'session/logout'

    get 'orders/index'
    get 'orders/show/:id', to: 'orders#show', as: 'order'  #get '/patients/:id', to: 'patients#show', as: 'patient'
    
    get 'orders/new'
    get 'orders/edit/:id', to: 'orders#edit', as: 'edit_order'

    get 'orders/create'
    patch 'orders/update/:id', to: 'orders#update', as: 'update_order'
    patch 'orders/receive/:id', to: 'orders#receive', as: 'receive_order'
    delete 'orders/destroy/:id', to: 'orders#destroy', as: 'delete_order'
    
    resources :animals

    get '/animals/index/clear', to: 'animals#clear', as: 'clear'

    resources :users
    root 'home#index'
    get 'home/profile'

    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

    # Defines the root path route ("/")
    # root "articles#index"
  end
end



