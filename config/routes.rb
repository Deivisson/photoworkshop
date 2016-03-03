Rails.application.routes.draw do

  #match "/", :controller => :facebook, :action => :canvas, :as => 'facebook_canvas', :via => [:post]  
  devise_for :admins
  namespace :admin do
    resources :categories
    resources :countries
    resources :states
    resources :workshop_plans
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
      get :publish
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
    resources :portfolio_templates, only: [:index], as:'portfolio_templates' do 
      get :preview, on: :collection
      put :buy
    end
    get '/states/:state/cities',:to => 'states#cities'
    resources :notifications, only: [:index] do
      get :set_all_as_read, on: :collection
    end

    #Favorite Photo
    get "favorite_photos/:photo_id/favoritar", to:'favorite_photos#favoritar', :as => :favoritar_photo
    get "favorite_photos/:photo_id/unfavoritar", to:'favorite_photos#unfavoritar', :as => :unfavoritar_photo

    get "user_profile/:user_id/workshop_wait", to: "user_profiles#workshop_wait", :as => :workshop_wait
    resources :workshop_plans, only:[:index]
    resources :rankings, only:[:index]
  end
  
  namespace :home do
    resources :welcome, only: [:index] do 
      get :contactus, on: :collection
      get :termsconditions, on: :collection
    end
    get "user_profile/:user_name/check_user_name", to: "user_profile#check_user_name", as: :check_user_name
    get "user_profile/:full_name/format_user_name", to: "user_profile#format_user_name", as: :format_user_name
  end

  namespace :public do
    #resources :portfolio, only:[:index]
    get "portfolio/photo/:template/:photo_id", to: "portfolio#get_photo", as: :get_photo
    get "portfolio/about/:user_name", to: "portfolio#about", as: :portfolio_about
    resources :photo, only:[:show]
    resources :photographers do
      get :following
      get :followers
      get :photos
      get :about
      get :workshops
    end
  end
  get "portfolio/:user_name", to: "public/portfolio#index", as: :photographer_public_portfolio
  get ":user_name", to: "public/photographers#show", as: :photographer_profile
 
  get "sign_up/finish", to:'omniauth_callbacks#sign_finish', :as => :sign_up_finish
  post "authentication/sign_up_finish/complete_sign_up", to:'authentication/sign_up_finish#complete_sign_up', :as => :complete_sign_up
  root "home/welcome#index"

end
