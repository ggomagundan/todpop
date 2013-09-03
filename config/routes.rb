# -*- encoding : utf-8 -*-
Todpop::Application.routes.draw do
   
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

    
    end

    resources :advertises do

      get 'get_ad', :on => :collection
      get 'set_log', :on => :collection

    end
  
    resources :studies do
      
      get 'get_level_test_words', :on => :collection
      get 'get_level_words', :on => :collection
      get 'get_word_info', :on => :collection

    end
    
    resources :products do
      get 'get_product_info', :on => :collection
    end
    
    get 'get_intro_movie'
  

  get 'test', :action => 'test'
  
  }
  
  namespace(:admin){ 
    root :to => "users#index"

    resources :users 
    resources :words
 
  
  }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'main#index'

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
