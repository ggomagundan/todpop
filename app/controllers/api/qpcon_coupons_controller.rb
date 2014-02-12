class Api::QpconCouponsController < ApplicationController
  protect_from_forgery :except => [:index, :show]
  
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

    user =  User.find_by_id(params[:user_id])
    coupon = QpconProduct.find_by_product_id(params[:product_id])

    if !user.authenticate(params[:password]).present?
      @status = false
      @msg = "비밀번호가 잘못 되었습니다."
    end

    if @status == true

      if user.current_reward >= coupon.common_cost

        timenow = Time.now.to_datetime 
        server_uri = "http://211.245.169.201/qpcon/api/pin"        # qpcon_test_server_URI
        
        qpcon_key       = "0f8f5a7024dd11e3b5ae00304860c864"       # qpcon_test_server_key_for_todpop
        qpcon_reqOrdId  = user.id.to_s + '_' + timenow.strftime('%Y%m%d') + '_' + timenow.strftime('%H%M%S') + '_' + timenow.strftime('%N')
        qpcon_prodId    = coupon.product_id
        qpcon_pinCnt    = 1
        qpcon_payGb     = nil
        qpcon_reserved1 = nil
        qpcon_reserved2 = nil

        issue_uri = URI.parse(server_uri + "/pinIssue.do")
        issue_params = {:key => qpcon_key, :reqOrdId => qpcon_reqOrdId, :prodId => qpcon_prodId}

        http = Net::HTTP.new(issue_uri.host, issue_uri.port)
        request = Net::HTTP::Post.new(issue_uri.request_uri)
        request.set_form_data(issue_params)
        @response = http.request(request)
        @response = @response.body

        response_all = @response.split("|")
        response_code     = response_all[0]
        response_msg      = response_all[1]
        response_reqOrdId = response_all[2]
        response_pin      = response_all[3]
        response_valid    = response_all[4]
        response_approval = response_all[5]
        response_date     = response_all[6]

        @return_msg = response_msg

        if response_code == "00"

          qpcon_admitId = response_approval
        
          admit_uri = URI.parse(server_url + "/pinIssueConfirm.do")
          admit_params = {:key => qpcon_key, :admitId => qpcon_admitId}

          http = Net::HTTP.new(admit_uri.host, admit_uri.port)
          request = Net::HTTP::Post.new(admit_uri.request_uri)
          request.set_form_data(admit_params)
          @response2 = http.request(request)
          @response2 = @response2.body

          response2_all = @response2.split("|")
          response2_code  = response2_all[0]
          response2_msg   = response2_all[1]

          @return_msg = response_msg + '_' + response2_msg

          if response2_code == "00"

            @result=true

            Order.create(:coupon_company => "qpcon", :user_id => user.id, :order_id => response_reqOrdId, :product_id => coupon.product_id, :barcode => response_pin, :limit_date => Date.strptime(response_valid,"%Y%m%d"), :approval_number => response_approval, :issue_date => response_date)

            #user.update_attributes(:total_reward => user.total_reward - coupon.common_cost)
            # reward process
            @token_user_id = user.id
            @token_reward_type = 7000
            @token_title = "상품구매:큐피콘"
            @token_sub_title = QpconProduct.find_by_id(coupon.id).product_name
            @token_reward = (-1).to_i * coupon.common_cost
            process_reward_general
            # ---------

          else
            @result = false
            @msg = "issue OK, admit FAIL"
          end
       
        else
          @result = false
          @msg = "issue FAIL"
        end
    
      else
        @msg = "장학금이 부족합니다"
        @result = false
        @status = false
      end

    end

  end
end
