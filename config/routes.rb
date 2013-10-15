# -*- encoding : utf-8 -*-
Todpop::Application.routes.draw do
   
  namespace(:admin){ resources :advertisements }
  namespace(:admin){ resources :app_infos }
  namespace(:admin){ resources :notices }
  #resources :notices

  resources :mains

  namespace(:admin){ resources :products }
  namespace(:admin){ resources :levels }
  resources :studies
  resources :users

  namespace(:api){ 
  
    resources :users do
      post 'sign_up', :on => :collection
      post 'sign_in', :on => :collection
      get 'resign_up_info', :on => :collection

      get 'check_mobile_exist', :on => :collection
      get 'check_facebook_exist', :on => :collection
      get 'check_email_exist', :on => :collection
      get 'check_recommend_exist', :on => :collection
      get 'check_nickname_exist', :on => :collection
      
      get 'address_list', :on => :collection

      get 'get_users_score', :on => :collection

      get 'get_users_point_list', :on => :member
      get 'get_users_attendance', :on => :member
      get 'set_users_attendance', :on => :member
      
      delete 'delete_user', :on => :member
      
      get 'change_password', :on => :member
      get 'setting_facebook_password', :on => :member
    
    end

    resources :advertises do

      get 'get_ad', :on => :collection
      get 'get_image_ads', :on => :collection
      get 'get_coupon_ads', :on => :collection
      get 'get_coupon', :on => :collection
      get 'set_log', :on => :collection

    end
  
    resources :studies do
      
      get 'get_level_test_words', :on => :collection
      get 'get_level_words', :on => :collection
      get 'get_word_info', :on => :collection
      get 'send_word_result', :on => :collection
      get 'get_possible_stage', :on => :collection

    end
    
    resources :products do
      get 'get_product_info', :on => :collection
    end
    
    resources :notices do
      get 'get_notices', :on => :collection
    end
    get 'get_intro_movie'
  
    resources :app_infos do
      get 'get_fast_pivot_time', :on => :collection
    end

  get 'test', :action => 'test'
  
  }
  
  namespace(:admin){ 
    root :to => "users#index"

    resources :users 
    resources :words
    get '/words/:id/delete', to: 'words#delete'
    get '/words/:word/get_img_url/:start', to: 'words#get_img_url'
  }

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'mains#index'

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
