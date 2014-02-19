# -*- encoding : utf-8 -*-
class Admin::ApplicationController < ActionController::Base
  before_filter :require_admin
  protect_from_forgery

  layout 'admin'
  helper_method :current_user
  
  def process_reward_general

    ########################################################
    #
    # [ Reward process ]
    #  - general : @token_user_id @token_reward_type @token_title @token_sub_title @token_reward
    #  - refund  : @token_bank @token_account @token_commenttle
    #
    # log : Reward
    # add : User.current_reward & User.total_reward
    #
    # refund case : RefundRequest
    #
    #######################################################

    # log to Reward (all history)
    RewardLog.create(:user_id => @token_user_id, :reward_type => @token_reward_type, :title => @token_title,
                    :sub_title => @token_sub_title, :reward => @token_reward)

    # add to User (current_reward, total_reward)
    user = User.find_by_id(@token_user_id)
    current_reward = user.current_reward
    total_reward = user.total_reward
    user.update_attributes(:current_reward => current_reward + @token_reward)
    user.update_attributes(:total_reward => total_reward + @token_reward)

    # refund to RefundRequest (all refund history)
    if @token_reward_type == 7000
      RefundRequest.create(:user_id => @token_user_id, :name => @token_name, :bank => @token_bank,
                          :account => @token_account, :amount => @token_reward, :comment => @token_comment)
    elsif @token_reward_type == 2000
      new_dtr = user.daily_test_reward + @token_reward
      user.update_attributes(:daily_test_reward => new_dtr)
    end

    if @token_reward_type == 9999
      redirect_to admin_users_path
    end

  end

  private
  def require_admin
    if !current_user.present?
      redirect_to new_session_path
    elsif current_user.is_admin == 0
      redirect_to new_session_path
    else
    end
  end
 def current_user
  @current_user ||= session[:user_id] && User.find_by_id(session[:user_id])
 end  

end
