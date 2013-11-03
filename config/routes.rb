# -*- encoding : utf-8 -*-
Sirass::Application.routes.draw do

  get "t/visual", to: "test_pages#visual"
  get "t/info", to: "test_pages#info"

  get "reportes", to: 'reports#index'

  resources :prestadors, path: "prestadores"
  resources :institucion_users, path: "institucions"
  resources :admins
  resources :sessions, only: [:new, :create, :destroy]

  # Programas
  resources :cprogramas do
    get 'internos',       to: 'cprogramas#index', internos: true, on: :collection
    get 'externos',       to: 'cprogramas#index', internos: false, on: :collection
    get 'cambiar_clave',  to: 'cprogramas#cambiar_clave', on: :member
    get 'search',         to: 'cprogramas#search', on: :collection
    member do
      get   'generar_nueva_clave',    to: 'cprogramas#generar_nueva_clave'
      match 'update_clave',           to: 'cprogramas#update_clave', via: :put
      match 'update_status/:status',  to: 'cprogramas#update_status'
      match 'update_observaciones',   to: 'cprogramas#update_observaciones'
      match 'print',                  to: 'cprogramas#print'
    end
  end

  match '/ayuda',     to: 'public_pages#ayuda'
  match '/programas', to: 'public_pages#programas'
  match '/proceso',   to: 'public_pages#proceso'

  # Autentificación
  match '/login',                 to: 'sessions#new'
  match '/logout',                to: 'sessions#destroy'
  match '/registro',              to: 'prestadors#new'
  match '/registro/institucion',  to: 'institucion_users#new'

  # Prestador
  scope "/prestador" do
    get 'home',                 to: 'prestador_pages#index', as: :prestador_home
    get 'search',               to: 'prestadors#search', as: :prestador_search
    get 'inscripcion',          to: 'inscripcions#new', as: :inscripcion_servicio
    get 'Articulo_91',          to: 'articulos#new', as: :by_articulo
    get 'Articulo_91/delete',   to: 'articulos#delete'
    get 'Articulo91',           to: 'prestador_pages#ins_articulo', as: :mi_inscripcion_art
    get 'articulo/edit',        to: 'prestador_pages#edit_articulo'
    get 'mi_inscripcion',       to: 'prestador_pages#inscripcion'
    get 'mi_inscripcion/edit',  to: 'prestador_pages#edit_inscripcion'
    put 'estudianteUACM',       to: 'prestador_pages#estudianteDe'
    get 'reporte_horas',        to: 'prestador_pages#reporte_horas'
    get 'carta_compromiso',     to: 'prestador_pages#carta_compromiso'
    get 'solicitud_servicio',   to: 'prestador_pages#solicitud_servicio'

    resources :monthly_reports,     path: 'control_horas', as: 'control_horas' do
      member do
        get 'print'
      end
    end

    resources :bi_monthly_reports,  path: 'informe_bimensual', as: 'informe_bimensual' do
      member do
        get 'imprimir'
      end
    end
    get 'informe_final/new',        to: 'prestador_pages#new_informe_final'
    get 'informe_final/edit',       to: 'prestador_pages#edit_informe_final'
    match 'informe_final',          to: 'prestador_pages#create_informe_final', via: :post
    match 'informe_final',          to: 'prestador_pages#update_informe_final', via: :put
    get 'informe_final/ver',        to: 'prestador_pages#show_informe_final'
    get 'informe_final/print',      to: 'prestador_pages#print_informe_final'
  end

  # resources :final_report

  # Institucion
  scope "/institucion" do
    get 'home',         to: 'institucion_pages#index',      as: :institucion_home
    get 'actualizar_programas',   to: 'institucion_pages#actualizar', as: :actualizar_programa_institucion
    get 'avisos',     to: 'institucion_pages#avisos'
    get 'Cancelar_Paseo', to: 'institucion_pages#paseo', as: :desact_ins
    get 'Ayuda', to: 'institucion_pages#ayuda', as: :ayuda_ins
  end
  # Admin pages
  get '/admin/home',                  to: 'admin_pages#index'
  get '/admin/reportes_mensuales',    to: 'admin_pages#reportes_mensuales'
  get '/admin/reportes_bimensuales',  to: 'admin_pages#reportes_bimensuales'
  get '/admin/reportes_finales',      to: 'admin_pages#reportes_finales'

  match '/admin/reportes_mensuales/:id/cambiar_estado/:estado_id',  to: 'monthly_reports#cambiar_estado', as: :cambiar_estado_reporte, via: :put
  match '/admin/reportes_bimensuales/:id/cambiar_estado/:estado_id',  to: 'bi_monthly_reports#cambiar_estado', as: :cambiar_estado_reporte_bim, via: :put
  match '/admin/reportes_finales/:id/cambiar_estado/:estado_id',  to: 'final_reports#cambiar_estado', as: :cambiar_estado_reporte_fin, via: :put
  get '/Convocatoria', to: 'admin_pages#update_convocatoria'
  # Admin
  # resources :institucions, :path => "/admin/institucions"
  # resources :plantels, :path => "/admin/plantels"
  scope "/admin" do
    resources :institucions
    resources :plantels
    resources :final_reports, except: [:create, :new, :index] do
      get 'print', to: "final_reports#print", on: :member
    end
    resources :inscripcions,        path: "inscripciones" do
      match 'update_observaciones',   to: 'inscripcions#update_observaciones', via: :put
      match 'update_status/:status',  to: 'inscripcions#update_status', as: 'update_status'
      get   'generar_nuevo_ncontrol', to: 'inscripcions#generar_nuevo_ncontrol', as: 'generar_ncontrol'
      get   'calcular_horas_servicio', to: 'inscripcions#calcular_horas_servicio', as: 'calcular_horas_servicio'
      get   'reportes_mensuales',     to: 'inscripcions#reportes_mensuales', on: :member
      get   'reportes_bimensuales',     to: 'inscripcions#reportes_bimensuales', on: :member
    end
    #Articulo 91
    resources :articulos, path: 'Articulo_91' do
      match 'Actualizar/:status',     to: 'articulos#update_stat', as: :update_stat
      match 'update_observaciones',   to: 'articulos#update_observaciones', via: :put
    end
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
  match ':controller(/:action(/:id))(.:format)'
end
