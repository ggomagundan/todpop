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
        qpcon_manager = QpconManager.new # initialize in devlopment 
        qpcon_result = qpcon_manager.request_purchase(user, coupon)

        @status = qpcon_result[:status]
        @msg = @msg + qpcon_result[:msg]

        if @status == true
          save_log_qpcon(user,coupon,qpcon_result)
          @msg = @msg + " / qpcon_issue done"
        else
          @msg = @msg + " / qpcon_issue fail"
        end
      else
        @status = false 
        @msg = "not enouth money"
      end      # end of enough money
    end        # end of status:true

  end          # end of def

=begin
  # --------------------------------------------------------------------------------------------------------------------
  def set_qpcon(user,coupon)

    qpcon = {}
    timenow = Time.now.to_datetime 
    qpcon[:serverUri] = "http://211.245.169.201/qpcon/api/pin"        # qpcon_test_server_URI
    #qpcon[:serverUri] = "http://211.233.60.195/qpcon/api/pin"        # qpcon_operation_server_URI
        
    qpcon[:key]        = "0f8f5a7024dd11e3b5ae00304860c864"       # qpcon_test_server_key_for_todpop
    qpcon[:reqOrdId]  = user.id.to_s + '_' + timenow.strftime('%Y%m%d') + '_' + timenow.strftime('%H%M%S') + '_' + timenow.strftime('%N')
    qpcon[:prodId]    = coupon.product_id
    qpcon[:pinCnt]    = 1
    qpcon[:payGb]     = nil
    qpcon[:reserved1] = nil
    qpcon[:reserved2] = nil

    return qpcon
  end
  # --------------------------------------------------------------------------------------------------------------------

  def issue_qpcon(qpcon)

    issue_uri = URI.parse(qpcon[:serverUri] + "/pinIssue.do")
    issue_params = {:key => qpcon[:key], :reqOrdId => qpcon[:reqOrdId], :prodId => qpcon[:prodId]}

    # clear corresponding resp
    qpcon = qpcon.merge(:respCode => nil, :respMsg => nil, :reqOrdId => nil, :pinNum => nil, :validDate => nil, :admitId => nil, :issueDate => nil)

    http = Net::HTTP.new(issue_uri.host, issue_uri.port)
    request = Net::HTTP::Post.new(issue_uri.request_uri)
    request.set_form_data(issue_params)
    response_all = http.request(request)
    response = response_all.body

    response_split = response.split("|")
    qpcon[:respCode]   = response_split[0]
    qpcon[:respMsg]    = response_split[1]
    qpcon[:reqOrdId]   = response_split[2]
    qpcon[:pinNum]     = response_split[3]
    qpcon[:validDate]  = response_split[4]
    qpcon[:admitId]    = response_split[5]
    qpcon[:issueDate]  = response_split[6]

    @return_msg = @return_msg.present? ? @return_msg + ' | ' + qpcon[:respMsg] : qpcon[:respMsg]

    return qpcon

  end
  # --------------------------------------------------------------------------------------------------------------------

  def cancel_qpcon(qpcon)

    cancel_uri = URI.parse(qpcon[:serverUri] + "/pinCancel.do")
    cancel_params = {:key => qpcon[:key], :admitId => qpcon[:admitId]}

    # clear corresponding resp
    qpcon = qpcon.merge(:respCode => nil, :respMsg => nil, :cancelDate => nil)

    http = Net::HTTP.new(cancel_uri.host, cancel_uri.port)
    request = Net::HTTP::Post.new(cancel_uri.request_uri)
    request.set_form_data(cancel_params)
    response_all = http.request(request)
    response = response_all.body

    response_split = response.split("|")
    qpcon[:respCode]    = response_split[0]
    qpcon[:respMsg]     = response_split[1]
    qpcon[:cancelDate]  = response_split[2]

    @return_msg = @return_msg.present? ? @return_msg + ' | ' + qpcon[:respMsg] : qpcon[:respMsg]

    return qpcon

  end
  # --------------------------------------------------------------------------------------------------------------------

  def info_qpcon(qpcon)

    info_uri = URI.parse(qpcon[:serverUri] + "/pinInfo.do")
    info_params = {:key => qpcon[:key], :admitId => qpcon[:admitId], :pinNum => qpcon[:pinNum]}

    # clear corresponding resp
    qpcon = qpcon.merge(:respCode => nil, :respMsg => nil, :reqOrdId => nil, :issueDate => nil, :admitId => nil, :pinStatus => nil, :useDate => nil, :cancelDate => nil, :validDate => nil)

    http = Net::HTTP.new(info_uri.host, info_uri.port)
    request = Net::HTTP::Post.new(info_uri.request_uri)
    request.set_form_data(info_params)
    response_all = http.request(request)
    response = response_all.body

    response_split = response.split("|")
    qpcon[:respCode]     = response_split[0]
    qpcon[:respMsg]      = response_split[1]
    qpcon[:reqOrdId]     = response_split[2]
    qpcon[:issueDate]    = response_split[3]
    qpcon[:admitId]      = response_split[4]
    qpcon[:pinStatus]    = response_split[5]
    qpcon[:useDate]      = response_split[6]
    qpcon[:cancelDate]   = response_split[7]
    qpcon[:validDate]    = response_split[8]

    @return_msg = @return_msg.present? ? @return_msg + ' | ' + qpcon[:respMsg] : qpcon[:respMsg]

    return qpcon

  end
  # --------------------------------------------------------------------------------------------------------------------

  def issue_query_qpcon(qpcon)

    query_uri = URI.parse(qpcon[:serverUri] + "/pinIssueResult.do")
    query_params = {:key => qpcon[:key], :reqOrdId => qpcon[:reqOrdId], :prodId => qpcon[:prodId]}

    # clear corresponding resp
    qpcon = qpcon.merge(:respCode => nil, :respMsg => nil, :reqOrdId => nil, :pinNum => nil, :validDate => nil, :admitId => nil, :issueDate => nil)

    http = Net::HTTP.new(query_uri.host, query_uri.port)
    request = Net::HTTP::Post.new(query_uri.request_uri)
    request.set_form_data(query_params)
    response_all = http.request(request)
    response = response_all.body

    response_split = response.split("|")
    qpcon[:respCode]   = response_split[0]
    qpcon[:respMsg]    = response_split[1]
    qpcon[:reqOrdId]   = response_split[2]
    qpcon[:pinNum]     = response_split[3]
    qpcon[:validDate]  = response_split[4]
    qpcon[:admitId]    = response_split[5]
    qpcon[:issueDate]  = response_split[6]

    @return_msg = @return_msg.present? ? @return_msg + ' | ' + qpcon[:respMsg] : qpcon[:respMsg]

    return qpcon

  end
  # --------------------------------------------------------------------------------------------------------------------

  def confirm_qpcon(qpcon)

    confirm_uri = URI.parse(qpcon[:serverUri] + "/pinIssueConfirm.do")
    confirm_params = {:key => qpcon[:key], :admitId => qpcon[:admitId]}

    # clear corresponding resp
    qpcon = qpcon.merge(:respCode => nil, :respMsg => nil)

    http = Net::HTTP.new(confirm_uri.host, confirm_uri.port)
    request = Net::HTTP::Post.new(confirm_uri.request_uri)
    request.set_form_data(confirm_params)
    response_all = http.request(request)
    response = response_all.body

    response_split = response.split("|")
    qpcon[:respCode]  = response_split[0]
    qpcon[:respMsg]   = response_split[1]

    @return_msg = @return_msg.present? ? @return_msg + ' | ' + qpcon[:respMsg] : qpcon[:respMsg]

    return qpcon

  end
  # --------------------------------------------------------------------------------------------------------------------
=end
  def save_log_qpcon(user,coupon,qpcon)

    Order.create(:coupon_company => "qpcon", :user_id => user.id, :order_id => qpcon[:reqOrdId], :product_id => coupon.product_id, :barcode => qpcon[:pinNum], :limit_date => Date.strptime(qpcon[:validDate],"%Y%m%d"), :approval_number => qpcon[:admitId], :issue_date => qpcon[:issueDate])

    # reward process
    @token_user_id = user.id
    @token_reward_type = 7000
    @token_title = "상품구매:큐피콘"
    @token_sub_title = QpconProduct.find_by_product_id(coupon.product_id).product_name
    @token_reward = (-1).to_i * coupon.market_cost
    process_reward_general
    # ---------
  end

  # --------------------------------------------------------------------------------------------------------------------




end
