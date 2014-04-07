class Api::QpconCouponsController < ApplicationController
  protect_from_forgery :except => [:index, :show]
  require File.dirname(__FILE__)+'/../../../lib/qpcon_manager.rb'

  
  def index
    @status = true
    @msg =""
  
    @coupons=[]
    if params[:category_id].present?
      tmp = QpconProduct.where(:qpcon_category_id => params[:category_id])
    else
      tmp = QpconProduct.all
    end
    tmp.each do |i|
      @coupons.push(:product_id => i.product_id, :img_url_70 => i.img_url_70, :product_name => i.product_name, 
                    :market_name => i.market_name, :stock_count => i.stock_count, :market_cost => i.market_cost)
    end
  end

  def can_shopping
    @status = true
    @msg ="open"
    @result = true

    if !params[:user_id].present?
      @status = false
      @msg = "need params"
      @result = false
    else

    store = AppInfo.first.store_open
    user =  User.find_by_id(params[:user_id])
    
    #if !user.is_set_facebook_password && user.email.nil
    if store == 0
      @result = false
      @msg = "closed"
    elsif store == 1
      if !user.is_set_facebook_password
        @result = false
        @msg ="need to set password"
      end
    elsif store == 2 && user.is_admin.to_i != 1
      @result = false
      @msg = "closed"
    end
    end
  end

  def get_categories
    @status = true
    @msg = ""

    @category = QpconCategory.all
  end 

  def product_list
    @status = true
    @msg  = ""
    #type = 1:Food  2:Drink 3:Beauty  4:Mart  5:ETC
    if !params[:type].present?
      @status = false
      @msg = "need parmas"
    else
      type = params[:type].to_i
      if type == 1
        id = ["KFC001", "M10226", "FDIK", "M10234", "M10249", "M10355"]
      elsif type == 2
        id = ["M10192", "M10157", "M10300", "M10371"]
      elsif type == 3
        id = ["M10188"]
      elsif type == 4
        id = ["M10255", "RC0024", "M10370"]
      elsif type == 5
        id = ["M10001", "M10305", "M10354"]
      end
      @list = []
      tmp = QpconProduct.where('qpcon_category_id in (?)', id)
      tmp.each do |i|
        @list.push(:product_id => i.product_id, :img_url_70 => i.img_url_70, :product_name => i.product_name, 
                      :market_name => i.market_name, :stock_count => i.stock_count, :market_cost => i.market_cost)
      end
    end
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
