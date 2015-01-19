LocalZoo::Application.routes.draw do
  resources :registrations

  get "home/index"
  devise_for :admins
  resources :carts
  
  get "places/refresh", as: :places_refresh
  
  resources :places

  devise_for :users
  resources :users
  
  # This route enables me to call carts_subtract with params to subtract points from user's card
  post "carts/subtract", as: :carts_subtract
  
  
  
  devise_scope :user do
  authenticated :user do
    root 'home#index', as: :authenticated_root
  end
  unauthenticated do
    root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  

  
  devise_scope :admins do
  authenticated :admin do
    root 'places#index', as: :authenticated_admin_root
  end
  unauthenticated do
    root 'devise/sessions#new', as: :unauthenticated_admin_root
    end
  end
  
  
  get "home/api", as: :api
  post "carts/checkin", as: :checkin
  post "registrations/register", as: :register
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'place#index', :as => 'place'
   root to: "home#index", :as => 'home'
  # root :to => 'place#index' , :as => 'place'
  #root :to => "devise/sessions#new"

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
