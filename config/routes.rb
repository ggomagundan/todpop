# -*- encoding : utf-8 -*-
Todpop::Application.routes.draw do
  get 'downloads' => "downloads#index" 

  get 'client' => "client#index", :as => "client_index"
  get 'client/detail' => "client#detail"
  
  post "sessions/client_sign_up" => "sessions#client_sign_up", :as => :client_sign_up_sessions
  post "sessions/sign_up" => "sessions#sign_up", :as => :sign_up_sessions
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  resources :sessions
  namespace(:admin){ resources :prizes }
  get "etc/refund_info"
  namespace(:admin){ resources :board_helps }
  namespace(:admin){ resources :cacao_ments }
  namespace(:admin){ resources :app_introduce_videos }
  namespace(:admin){ resources :cpx_advertisements }
  namespace(:admin){ resources :cpdm_advertisements }
  namespace(:admin){ resources :cpd_advertisements }

  namespace(:admin){ resources :app_infos }
  namespace(:admin){ resources :board_notices }
  #resources :notices

  resources :mains

  get "category_list" => "mains#category_list"

  namespace(:admin){ resources :products }
  namespace(:admin){ resources :levels }

  namespace(:api){ 
=begin
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
      
      post 'delete_user', :on => :member
      
      post 'change_password', :on => :member
      get 'setting_facebook_password', :on => :member
      get 'facebook_change_pw', :on => :member
      post 'facebook_change_pw', :on => :member

      get 'is_set_facebook_password', :on => :member
      get 'get_reward_list', :on => :member
      get 'get_attendance_time', :on => :member

      get 'delete_user', :on => :member
    end

    resources :advertises do

      get 'get_ad', :on => :collection
      get 'get_image_ads', :on => :collection
      get 'get_coupon_ads', :on => :collection
      get 'get_coupon', :on => :collection
      get 'get_cpd_ad', :on => :collection
      get 'get_cpdm_ad', :on => :collection
      get 'get_cpx_ad', :on => :collection
      get 'set_cpd_log', :on => :collection
      get 'get_coupons', :on => :collection
      get 'set_cpdm_log', :on => :collection
      get 'set_cpx_log', :on => :collection
      get 'get_cps_questions', :on => :collection
      get 'set_survey_result', :on => :collection
      get 'show_cpx_ad', :on => :collection
    end
  
    resources :studies do
      
      get 'get_level_test_words', :on => :collection
      get 'get_level_words', :on => :collection
      get 'get_word_info', :on => :collection
      get 'send_word_result', :on => :collection
      get 'get_possible_stage', :on => :collection
      get 'get_stage_info', :on => :collection

    end
    
    resources :prizes do
      get 'get_prize_info', :on => :collection
    end
    
    get 'get_intro_movie'
  
    resources :app_infos do
      get 'get_fast_pivot_time', :on => :collection
      get 'get_cacao_msg', :on => :collection
      get 'get_notices', :on => :collection
      get 'get_helps', :on => :collection
    end
=end
    resources :etc do
      get 'refund_info', :on => :member
      get 'get_bank_list', :on => :collection
      post 'refund', :on => :collection
      get 'get_purchase_list', :on => :member
      get 'show_cpx_list', :on => :member
      get 'my_home', :on => :member
      get 'get_product_info', :on => :collection
      get 'get_coupon_free_info', :on => :member
      get 'event_check', :on => :member
      get 'update_rank_point', :on => :collection
      get 'character', :on => :member
      get 'main_notice', :on => :collection
      get 'user_count', :on => :collection
      get 'stage_initialization', :on => :collection
      get 'cpa_test', :on => :collection
      get 'launching', :on => :collection
    end

  
  }
  
  namespace(:admin){ 
    root :to => "users#index"

    resources :users 
    resources :words
    get '/words/:id/delete' => 'words#delete'
    get '/words/:word/get_img_url/:start' => 'words#get_img_url'
    get '/words/dummy/confirm' => 'words#confirm'
    post '/words/dummy/confirm' => 'words#confirm'
    patch '/words/dummy/:id/confirm' => 'words#confirm'

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
