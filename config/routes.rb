Rails.application.routes.draw do

  
  devise_for :admins
  namespace :admin do
    resources :categories
    resources :countries
    resources :states
  end
  
  devise_for :users,controllers: {registrations: "authentication/registrations",
                                 omniauth_callbacks:"authentication/omniauth_callbacks"}

  namespace :user do 
    root "home#index"
    resources :home, :only => [:index]
    resources :first_login_steps, :only => [:index] do 
      get :forward, to: "first_login_steps#step"
      get :backward, to: "first_login_steps#step"
    end
    resources :photos do 
      resources :photo_comments, only: [:create,:destroy]
      resources :photo_ratings, only: [:index] do
        put :save, on: :collection
      end
    end
    resources :user_profiles, :as => :profiles, :only => [:show,:edit,:update]
    get "profile/edit_cover_photo", to:"user_profiles#edit_cover_photo", :as => :edit_cover_photo
    put "profile/:photo_id/update_cover_photo", to:"user_profiles#update_cover_photo", :as => :update_cover_photo
    post "profile/social_network_shared/:provider", to: "user_profiles#social_network_shared"
    
    get "photo_likes/:photo_id/like", to: "photo_likes#like", :as => :photo_like
    get "photo_likes/:photo_id/unlike", to: "photo_likes#unlike", :as => :photo_unlike
    resources :photographers, only: [:index,:show] do
      get :follow
      get :unfollow
      get :following
      get :followers
      get :photos
      get :about
      get :workshops
    end
    
    resources :workshops do
      get :open
      get :marketing
      post :subscribe
      resources :workshop_materials, as: :materials, except: [:create,:update,:index,:show]
      resources :workshop_materials, only: [:create,:update]
      resources :workshop_participants, as: :participants, only: [:index,:destroy]
      get "workshop_participants/:user_id/add", to:'workshop_participants#add', :as => :add_participant
      delete "workshop_participants/:user_id/remove", to:'workshop_participants#remove', :as => :remove_participant
      put  "workshop_participants/:user_id/confirm_matriculation", to:'workshop_participants#confirm_matriculation', :as => :confirm_matriculation
      resources :workshop_activities, as: :activities, except: [:index] do 
        resources :workshop_activity_responses, as: :responses, except: [:index] 
      end
      resources :workshop_activities, only: [:create,:update]
    end
    #explore resources
    get "photo_explore", to: "photo_explore#index", as: :photo_explore
    get "photo_explore/:photo_id", to: "photo_explore#show", as: :photo_explore_show
    resources :portfolios, only: [:index] do 
      get :preview, on: :collection
    end
    get '/states/:state/cities',:to => 'states#cities'
    resources :notifications, only: [:index] do
      get :set_all_as_read, on: :collection
    end

    #Favorite Photo
    get "favorite_photos/:photo_id/favoritar", to:'favorite_photos#favoritar', :as => :favoritar_photo
    get "favorite_photos/:photo_id/unfavoritar", to:'favorite_photos#unfavoritar', :as => :unfavoritar_photo
  end
  
  namespace :home do
    resources :welcome, only: [:index] do 
      get :contactus, on: :collection
    end
  end

  namespace :public do
    resources :portfolio, only:[:index]
    get "portfolio/:photo_id", to: "portfolio#get_photo", as: :get_photo
    resources :photo, only:[:show]
  end

  get "sign_up/finish", to:'omniauth_callbacks#sign_finish', :as => :sign_up_finish
  post "authentication/sign_up_finish/complete_sign_up", to:'authentication/sign_up_finish#complete_sign_up', :as => :complete_sign_up
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
