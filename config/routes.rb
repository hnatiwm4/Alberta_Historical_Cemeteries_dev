HistoricalCemeteriesDev::Application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  
  # specify root or default home page
  root to: 'pages#home'

  # get routes for static pages for general layout
  # get "pages/home"
  match '/home', to: 'pages#home', via: 'get'
  # get "pages/about"
  match '/about', to: 'pages#about', via: 'get'
  # get "pages/contact"
  match '/contact', to: 'pages#contact', via: 'get'
  # get "pages/submit"
  match '/submit', to: 'pages#submit', via: 'get'
  # get "users/signup"
  match '/signup', to: 'users#new', via: 'get'
  # get "sessions/signin"
  match '/signin', to: 'sessions#new', via: 'get'
  # delete "sessions/signout"
  match '/signout', to: 'sessions#destroy', via: 'delete'
  # get "users/index"
  match '/users_path', to: 'users#index', via: 'get'

  # rendered partials using AJAX for submit tabs on submit page (must have corresponding .js.erb files)
  match "cemeteries/submit", to: 'cemeteries#submit', via: 'get'
  match "burials/submit", to: 'burials#submit', via: 'get'

  # resource for cemetery records
  resources :cemeteries do
    collection do
      get :search
      post :search
    end

  end

  resources :burials do
    collection do
      get :search
      post :search
    end

  end

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
