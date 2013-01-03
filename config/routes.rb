# -*- encoding : utf-8 -*-
Sirass::Application.routes.draw do
  get "test_pages/visual"

  resources :prestadors
  resources :institucion_users, path: "institucions"
  resources :admins
  resources :sessions, only: [:new, :create, :destroy]

  match '/t/visual',  to: 'test_pages#visual'

  match '/ayuda',     to: 'public_pages#ayuda'
  match '/programas', to: 'public_pages#programas'
  match '/proceso',   to: 'public_pages#proceso'

  # Autentificación
  match '/login',                 to: 'sessions#new'
  match '/logout',                to: 'sessions#destroy'
  match '/registro',              to: 'prestadors#new'
  match '/registro/institucion',  to: 'institucion_users#new'

  # Prestador
  match '/prestador/home',    to: 'prestador_pages#index'
  match '/institucion/home',  to: 'institucion_pages#index'
  get '/admin/home',          to: 'admin_pages#index'
  # Admin
  # resources :institucions, :path => "/admin/institucions"
  # resources :plantels, :path => "/admin/plantels"
  namespace :admin do
    resources :institucions
    resources :plantels
  end

  root to: 'public_pages#index'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end