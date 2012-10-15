Sportsstore::Application.routes.draw do
  root :to => 'product#index'
  
  match 'product' => 'product#index', :as => :product, :via => :get
  match 'product/index(/:page)' => 'product#index_paged', :as => :product_paged, :via => :get
  match 'product(/:category)' => 'product#category', :as => :category, :via => :get
  match 'product(/:category(/:page))' => 'product#category_paged', :as => :category_paged, :via => :get
  
  match 'cart' => 'cart#index', :as => :cart, :via => :get
  match 'cart/add(/:id)' => 'cart#add', :as => :cart_add, :via => :post
  match 'cart/remove(/:id)' => 'cart#remove', :as => :cart_remove, :via => :post
  match 'cart/checkout' => 'cart#checkout', :as => :cart_checkout, :via => [:get, :post]
  
  match 'productimg(/:id)' => 'product#getimage', :as => :image, :via => :get
  
  namespace :admin do
    match 'product' => 'product#index', :as => :product, :via => :get
    match 'product/new' => 'product#new', :as => :product_new, :via => :get
    match 'product/create' => 'product#create', :as => :product_create, :via => :post
    match 'product/edit(/:id)' => 'product#edit', :as => :product_edit, :via => :get
    match 'product/update(/:id)' => 'product#update', :as => :product_update, :via => :put
    match 'product/delete(/:id)' => 'product#destroy', :as => :product_delete, :via => [:get, :delete]
    
    match 'login' => 'admin#new', :as => :login
    match 'auth' => 'admin#create', :as => :auth
    match 'logout' => 'admin#destroy', :as => :logout
  end
  
  namespace :mobile do
    match 'product' => 'product#index', :as => :product, :via => :get
    match 'product/index(/:page)' => 'product#index_paged', :as => :product_paged, :via => :get
    match 'product(/:category)' => 'product#category', :as => :category, :via => :get
    match 'product(/:category(/:page))' => 'product#category_paged', :as => :category_paged, :via => :get
    match 'product/list(/:page)' => 'product#list_paged', :as => :list_paged, :via => :post
    
    match 'cart' => 'cart#index', :as => :cart, :via => :get
    match 'cart/add(/:id)' => 'cart#add', :as => :cart_add, :via => :get
    match 'cart/remove(/:id)' => 'cart#remove', :as => :cart_remove, :via => :get
    match 'cart/checkout' => 'cart#checkout', :as => :cart_checkout, :via => [:get, :post]
  end
  
  # refer to http://guides.rubyonrails.org/routing.html

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
