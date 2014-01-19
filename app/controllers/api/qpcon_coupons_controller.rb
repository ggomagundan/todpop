class Api::QpconCouponsController < ApplicationController
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
    user =  User.find(params[:user_id])
    
    if !user.is_set_facebook_password  && user.email.nil
      @status = false
      @result = false
      @msg ="상품구매와 장학금 수여를 위해서는 비밀번호를 설정해야 합니다. 마이페이지에서 비밀번호를 설정해주세요"
    end
  end

  def get_categories
    @status = true
    @msg = ""

    @category = QpconCategory.all

  end 


  def purchase
    @status = true
    @msg = ""
    @result = false

    @return_msg = ""

    user =  User.find(params[:user_id])
    coupon = QpconProduct.find(params[:coupon_id])


    if user.total_reward >= coupon.common_cost


      user.update_attributes(:total_reward => user.total_reward - coupon.common_cost)

      last_uri = "pinIssue.do"
      c_params = {:prodId => coupon.product_id,:reqOrdId => Time.now.to_datetime.strftime('%Y-%m-%d %H:%M:%S.%N') }

      uri = URI.parse("http://211.245.169.201/qpcon/api/pin/#{last_uri}")
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data(c_params.merge!({:key=> KEY}))
      @response = http.request(request)
      @response = @response.body

      pin_list = @response.split("|")
      @return_msg = pin_list[1]
      if pin_list[0] == "00"

        @result = true
       
       Order.create(:user_id => user.id, :order_id => pin_list[2], :barcode => pin_llist[3], :product_id => coupon.id, :qpcon_order_id => pin_list[5], :limit_date =>  Date.strptime(pin_list[4],"%Y%m%d") )
       
      else
        @result = false
      end
    else
      @msg = "장학금이 부족합니다"
      @result = false
      @status = false
    end

  end
end
