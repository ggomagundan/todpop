class Api::QpconCouponsController < ApplicationController
  protect_from_forgery :except => [:index, :show]
  require File.dirname(__FILE__)+'/../../../lib/qpcon_manager.rb'

  
  def index
    @status = true
    @msg =""
  
    @coupons = QpconProduct.all
    if params[:category_id].present?
      @coupons = @coupons.where(:qpcon_category_id => params[:category_id])
    end
  end

  def can_shopping
    @status = true
    @msg =""
    @result = true

    user =  User.find_by_id(params[:user_id])
    
    #if !user.is_set_facebook_password && user.email.nil
    if !user.is_set_facebook_password
      @status = false
      @result = false
      @msg ="need to set password"
    end
  end

  def get_categories
    @status = true
    @msg = ""

    @category = QpconCategory.all
  end 


  # --------------------------------------------------------------------------------------------------------------------
  def purchase
    @status = true
    @msg = "purchase start"

    user =  User.find_by_id(params[:user_id])
    coupon = QpconProduct.find_by_product_id(params[:product_id])

    if !params[:user_id].present? || !params[:password].present? || !params[:product_id].present?
      @status = false
      @msg = "need params"
    elsif !user.present?
      @status = false
      @msg = "wrong user_id"
    elsif !user.authenticate(params[:password]).present?
      @status = false
      @msg = "wrong password"
    elsif !coupon.present?
      @status = false
      @msg = "no coupon found (by product id)"
    end

    if @status == true
      if user.current_reward >= coupon.market_cost

        # first charge before buying (for safety)
        first_charge(user,coupon)

        qpcon_manager = QpconManager.new # initialize in devlopment 
        qpcon_result = qpcon_manager.request_purchase(user, coupon)

        @status = qpcon_result[:status]
        @msg = @msg + qpcon_result[:msg]

        if @status == true
          save_log_qpcon(user,coupon,qpcon_result)
          @msg = @msg + " / qpcon_issue done"
        else
          return_reward(user,coupon)
          @msg = @msg + " / qpcon_issue fail"
        end
      else
        @status = false 
        @msg = "not enouth money"
      end      # end of enough money
    end        # end of status:true

  end          # end of def

  # -------------------------------------------------------------------------------------------------------------------

  def first_charge(user,coupon)
    # reward process
    @token_user_id = user.id
    @token_reward_type = 8100
    @token_title = "상품구매:큐피콘"
    @token_sub_title = QpconProduct.find_by_product_id(coupon.product_id).product_name
    @token_reward = (-1).to_i * coupon.market_cost
    process_reward_general
    # ---------
  end

  def return_reward(user,coupon)
    # reward process
    @token_user_id = user.id
    @token_reward_type = 8200
    @token_title = "상품구매실패:큐피콘"
    @token_sub_title = QpconProduct.find_by_product_id(coupon.product_id).product_name
    @token_reward = (+1).to_i * coupon.market_cost
    process_reward_general
    # ---------
  end

  def save_log_qpcon(user,coupon,qpcon)
    Order.create(:coupon_company => "qpcon", :user_id => user.id, :order_id => qpcon[:reqOrdId], :product_id => coupon.product_id, :barcode => qpcon[:pinNum], :limit_date => Date.strptime(qpcon[:validDate],"%Y%m%d"), :approval_number => qpcon[:admitId], :issue_date => qpcon[:issueDate])
  end



end
