PetThing::Application.routes.draw do


  resources :airports , :path => "aeropuertos"
  resources :cities , :path => "ciudades"
  resources :arles
  resources :epses
  resources :users, :path => "usuarios"
  resources :roles, :path => "roles"
  resources :departments, :path => "departamentos"
  resources :countries, :path => "paises"
  resources :arles, :path => "arls"
  resources :epses, :path => "eps"
  get 'reset_passwords/new'

  get 'pages/home'
  get 'pages/contact'
  get 'pages/help'
  
  resources :products
  resources :sessions
  resources :reset_passwords, only: [:new, :create, :update, :edit]

  resources :messages do
    member do
      post :new
    end
  end

  resources :conversations do
    member do
      post :reply
      post :trash
      post :untrash
    end
    collection do
      get :trashbin
      post :empty_trash
    end
  end


  get       'signup', to:   'users#new',  as: :signup
  get       'login',  to:   'sessions#new',       as: :login
  post      'login',  to:   'sessions#create'
  delete    'logout', to:   'sessions#destroy',   as: :logout


  resources :patients, :path => "pascientes" do
    resources :clinic_histories, :path => "historias_clinicas" do
      resources :progress_notes, :path => "nota_de_evolucion"
    end
  end
  root to: 'pages#home'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end