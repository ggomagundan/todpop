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

    dead_product = dead_product()
    alive = tmp.where('product_id not in (?)', dead_product)

    alive.each do |i|
      @coupons.push(:product_id => i.product_id, :img_url_70 => i.img_url_70, :product_name => i.product_name, 
                    :market_name => i.market_name, :stock_count => i.stock_count, :market_cost => i.market_cost)
    end
  end

  def dead_product
    dead=[]
    dead=dead+["P000005138","P000005889","P000006190"]		# 2014-04-02 GS25
    dead=dead+["P000004992"]	# 2014-04-07 BR31
    dead=dead+["P000003142","P000003143","P000004240","P000004239","P000004242","P000004252","P000004236","P000004231","P000004232"]		# 2014-04-00 ETUDE
    dead=dead+["P000002878","P000002879","P000002883","P000002886","P000002888","P000002890","P000002892","P000002896","P000002897","P000003832","P000002903","P000002898","P000002899","P000002900","P000002901","P000002905","P000002907","P000004906"] #2014-04-16 SmoothyKing
    dead=dead+["G120467","P000003660","P000003677","P000006167","G120454","P000003731","P000003732","P000006168"]	# 2014-04-18 touslesjours
    dead=dead+["P000005168","P000005808","P000005166"] # 2014-04-21-18:00
    dead=dead+["P000005535"]  # 2014-04-29 18:00  CU
    dead=dead+["P000005145"]  # 2014-05-14 18:00  KFC
    dead=dead+["P000005775","P000005776"]  # 2014-05-26 18:00  CU
    dead=dead+["P000003896","P000005328","P000005403","G120633","P000004463","P000005339","P000005384","P000004469","P000005346","P000005378"]  # 2014-05-27 18:00  angelinus
    dead=dead+["P000004547"]  # 2014-05-29 18:00  Angelinus
    dead=dead+["P000004993"]  # 2014-06-03 18:00  BR31
    dead=dead+["P000006347","P000006346","P000006335","P000006336","P000002891","P000002906"]  # 2014-06-03 18:00  BR31
    dead=dead+["P000003715","P000003736","P000003672","P000003734","P000005773","P000005768"]  # 2014-07-14 18:00 touslesjours
    dead=dead+["P000005021"]
    dead=dead+["P000002893","P000002882","P000002887","P000002889","P000002908"]
    return dead
  end

  def can_shopping
    @status = true
    @msg = "open"
    @result = 1

    if !params[:user_id].present?
      @status = false
      @msg = "need params"
      @result = 0
    else

      store = AppInfo.first.store_open
      user =  User.find_by_id(params[:user_id])
    
      #if !user.is_set_facebook_password && user.email.nil
      if store == 0
        @result = 0
        @msg = "closed"
      elsif store == 1
        if !user.is_set_facebook_password
          @result = 2
          @msg ="need to set password"
        end
      elsif store == 2 && user.is_admin.to_i != 1
        @result = 0
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

      dead_product = dead_product()
      alive = tmp.where('product_id not in (?)', dead_product)

      alive.each do |i|
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
    elsif !coupon.present?
      @status = false
      @msg = "no coupon found (by product id)"
    end

    if @status == true
      store = AppInfo.first.store_open
      if store == 0
        @status = false
        @msg = "store closed"
      elsif store == 1
      elsif store == 2 && user.is_admin.to_i != 1
        @status = false
        @msg = "store closed"
      end
    end

    if @status == true && !user.authenticate(params[:password]).present?
      @status = false
      @msg = "wrong password"
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
