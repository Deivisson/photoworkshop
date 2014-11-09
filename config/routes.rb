
Rails.application.routes.draw do

  devise_for :admins
  namespace :admin do
    resources :categories
    resources :countries
    resources :states
  end
  
  devise_for :users
  namespace :user do 
    root "dashboard#index"
    resources :dashboard, :only => [:index]
    resources :photos do 
      resources :photo_comments, only: [:create,:destroy]
    end
    resources :user_profiles, :as => :profiles, :only => [:show,:edit,:update]
    get "photo_likes/:photo_id/like", to: "photo_likes#like", :as => :photo_like
    get "photo_likes/:photo_id/unlike", to: "photo_likes#unlike", :as => :photo_unlike
    resources :photographers, only: [:index] do
      get :follow
      get :unfollow
      get :following, on: :collection
      get :followers, on: :collection
    end
    
    resources :workshops do
      get :open
      resources :workshop_materials, as: :materials, except: [:create,:update,:index,:show]
      resources :workshop_materials, only: [:create,:update]
      resources :workshop_participants, as: :participants, only: [:index,:destroy]
      get "workshop_participants/:user_id/add", to:'workshop_participants#add', :as => :add_participant
      delete "workshop_participants/:user_id/remove", to:'workshop_participants#remove', :as => :remove_participant
      resources :workshop_activities, as: :activities, except: [:create,:update,:index,:show]
      resources :workshop_activities, only: [:create,:update]
    end
    get "explore/index", as: :explore
  end
  
  scope :home do
    resources :welcome
  end
  root "home/welcome#index"

  

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
