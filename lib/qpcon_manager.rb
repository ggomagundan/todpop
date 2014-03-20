class QpconManager
  PRODUCT_END_POINT = {
    :pin_issue                => "http://211.233.60.195/qpcon/api/pin/pinIssue.do",
    :pin_issue_confirm        => "http://211.233.60.195/qpcon/api/pin/pinIssueConfirm.do",
    :pin_cancle               => "http://211.233.60.195/qpcon/api/pin/pinCancel.do",
    :pin_issue_result         => "http://211.233.60.195/qpcon/api/pin/pinIssueResult.do",
    :pin_info                 => "http://211.233.60.195/qpcon/api/pin/pinInfo.do"
  }

  TEST_END_POINT = {
    :pin_issue                => "http://211.245.169.201/qpcon/api/pin/pinIssue.do",
    :pin_issue_confirm        => "http://211.245.169.201/qpcon/api/pin/pinIssueConfirm.do",
    :pin_cancle               => "http://211.245.169.201/qpcon/api/pin/pinCancel.do",
    :pin_issue_result         => "http://211.245.169.201/qpcon/api/pin/pinIssueResult.do",
    :pin_info                 => "http://211.245.169.201/qpcon/api/pin/pinInfo.do"
  }

  AUTH_KEY = {
    :product_key              => "aaaaaaa",
    :test_key                 => "0f8f5a7024dd11e3b5ae00304860c864"
  }

  # attr_accessor :key, :end_point, :status, :request_params, :respons_params, :user, :coupon

  # ---------------------------------------------------------------------------------------------------------------

  # mode == 0 : 개발 모드
  # mode == 1 : 운영 모드


  def initialize(mode = 0)
    if mode == 1
      @key = AUTH_KEY[:product_key]
      @end_point = PRODUCT_END_POINT
    else
      @key = AUTH_KEY[:test_key]
      @end_point = TEST_END_POINT
    end

    @params = {}
  end

  # ------------------------------------------------------------------------------------------------------------------

  # HTTP connect

  # 실제 연결하여 응답을 가져오는 함수
  def request_http(url,params = nil)

    @params[:respCode]=nil     # for the safety

    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data( params ? params : @params)
    response_string = http.request(request)
    return response_string.body
  end

  # ------------------------------------------------------------------------------------------------------------------

  # set params

  # put default params into global variable 
  def prepare_default_params (user, coupon)
    @params[:key] = @key
    timenow = Time.now.to_datetime
    @params[:reqOrdId]  = user.id.to_s + '_' + timenow.strftime('%Y%m%d') + '_' + timenow.strftime('%H%M%S') + '_' + timenow.strftime('%N')
    @params[:prodId]    = coupon.product_id
    @params[:pinCnt]    = 1
    @params[:payGb]     = nil
    @params[:reserved1] = nil
    @params[:reserved2] = nil
  end

  # prepare params for pin issue
  def set_pin_issue_params
    params = {}
    params[:key]          = @params[:key]
    params[:reqOrdId]     = @params[:reqOrdId]
    params[:prodId]       = @params[:prodId]
    params[:pinCnt]       = @params[:pinCnt]
    params[:payGb]        = @params[:payGb]
    params[:reserved1]    = @params[:reserved1]
    params[:reserved2]    = @params[:reserved2]
    return params
  end

  # prepare params for pin issue confirm
  def set_pin_issue_confirm_params
    params = {}
    params[:key] = @key
    params[:admitId] = @params[:admitId]
    return params
  end

  # parepare params for pin cancel
  def set_pin_cancel_params
    params = {}
    params[:key]       = @params[:key]
    params[:admitId]   = @params[:admitId]
    params[:pinNum]    = @params[:pinNum]
    params[:reserved1] = @params[:reserved1]
    params[:reserved2] = @params[:reserved2]
    return params
  end

  # prepare params for pin issue result
  def set_pin_issue_result_params
    params = {}
    params[:key]          = @params[:key]
    params[:reqOrdId]     = @params[:reqOrdId]
    params[:prodId]       = @params[:prodId]
    params[:reserved1]    = @params[:reserved1]
    params[:reserved2]    = @params[:reserved2]
    return params
  end

  # parepare params for pin info
  def set_pin_info_params
    params = {}
    params[:key]       = @params[:key]
    params[:admitId]   = @params[:admitId]
    params[:pinNum]    = @params[:pinNum]
    params[:reserved1] = @params[:reserved1]
    params[:reserved2] = @params[:reserved2]
    return params
  end

  # -----------------------------------------------------------------------------------------------------------

  # parsing

  # for pin issue
  def parse_pin_issue_response(response)
    response_split = response.split("|")
    @params[:respCode]   = response_split[0]
    @params[:respMsg]    = response_split[1]
    @params[:reqOrdId]   = response_split[2]
    @params[:pinNum]     = response_split[3]
    @params[:validDate]  = response_split[4]
    @params[:admitId]    = response_split[5]
    @params[:issueDate]  = response_split[6]

    @msg = @msg + " / pin issue(" + @params[:respCode] + ")"
  end

  # for pin issue confirm
  def parse_pin_issue_confirm_response(response)
    response_split = response.split("|")
    @params[:respCode] = response_split[0]
    @params[:respMsg]  = response_split[1]

    @msg = @msg + " / pin issue confirm(" + @params[:respCode] +")"
  end

  # for pin cancel
  def parse_pin_cancel_response(response)
    response_split = response.split("|")
    @params[:respCode]   = response_split[0]
    @params[:respMsg]    = response_split[1]
    @params[:cancelDate] = response_split[2]

    @msg = @msg + " / pin cancel(" + @params[:respCode] +")"
  end

  # for pin issue result
  def parse_pin_issue_result_response(response)
    response_split = response.split("|")
    @params[:respCode]   = response_split[0]
    @params[:respMsg]    = response_split[1]
    @params[:reqOrdId]   = response_split[2]
    @params[:pinNum]     = response_split[3]
    @params[:validDate]  = response_split[4]
    @params[:admitId]    = response_split[5]
    @params[:issueDate]  = response_split[6]

    @msg = @msg + " / pin issue result(" + @params[:respCode] +")"
  end

  # for pin info
  def parse_pin_info_response(response)
    response_split = response.split("|")
    @params[:respCode]     = response_split[0]
    @params[:respMsg]      = response_split[1]
    @params[:reqOrdId]     = response_split[2]
    @params[:issueDate]    = response_split[3]
    @params[:admitId]      = response_split[4]
    @params[:pinStatus]    = response_split[5]
    @params[:useDate]      = response_split[6]
    @params[:cancelDate]   = response_split[7]
    @params[:validDate]    = response_split[8]

    @msg = @msg + " / pin info(" + @params[:respCode] +")"
  end

  # ------------------------------------------------------------------------------------------------------

  def request_pin_issue
    params = set_pin_issue_params
    response = request_http(@end_point[:pin_issue],params)
    parse_pin_issue_response(response)
    return @params[:respCode]
  end

  def request_pin_issue_confirm
    params = set_pin_issue_confirm_params
    response = request_http(@end_point[:pin_issue_confirm],params)
    parse_pin_issue_confirm_response(response)
    return @params[:respCode]
  end

  def request_pin_cancel
    params = set_pin_cancel_params
    response = request_http(@end_point[:pin_cancel],params)
    parse_pin_cancel_response(response)
    return @params[:respCode]
  end

  def request_pin_issue_result
    params = set_pin_issue_result
    response = request_http(@end_point[:pin_issue_result],params)
    parse_pin_issue_result_response(response)
    return @params[:respCode]
  end

  def request_pin_info
    params = set_pin_info_params
    response = request_http(@end_point[:pin_info],params)
    parse_pin_info_response(response)
    return @params[:respCode]
  end

  # ----------------------------------------------------------------------------------------------------

  def do_pin_cancel_loop
    respCode = request_pin_cancel
    cnt = 1

    while respCode != "00" && cnt < 5 do 
      sleep 1
      respCode = request_pin_cancel
      cnt = cnt+1
    end

    return respCode
  end

  def do_pin_issue_result_loop
    respCode = request_pin_issue_result
    cnt = 1

    while respCode != "00" && cnt < 5 do 
      sleep 1
      respCode = request_pin_issue_result
      cnt = cnt+1
    end

    return respCode
  end

  # ----------------------------------------------------------------------------------------------------

  # Start purchasing
  def request_purchase(user, coupon)
    @status = true
    @msg = ""

    prepare_default_params(user, coupon)
    respCode = request_pin_issue

    if respCode == "00"              #일반 상품 핀 발행  성공 , 확정 api 호출
      respCode = request_pin_issue_confirm
      if respCode == "00"
        @status = true
      else
        do_pin_cancel_loop
        @status = false
      end

    elsif respCode == "10"      # 연동 상품 핀 발행  ,상품 조회 api와 핀 확정 api 호출
      respCode = do_pin_issue_result_loop
      if respCode == "00"
        respCode = request_pin_issue_confirm
        if respCode == "00"
          @status = true
        else
          do_pin_cancel_loop
          @status = false
        end
      else
        @status = false
      end

    else
      @status = false     # respCode is not "00" nor "10" : auto cancel : do nothing but just false
    end

    # prepare return values
    hash_tmp=@params
    hash_tmp[:status]=@status
    hash_tmp[:msg]=@msg
    return hash_tmp
  end

  # ----------------------------------------------------------------------------------------------------

  # Start pin info
  def request_info_query(coupon)
    @status = true
    @msg = ""

    @params[:key]       = @key
    @params[:admitId]   = coupon.approval_number
    @params[:pinNum]    = coupon.barcode
    @params[:reserved1] = nil
    @params[:reserved2] = nil

    respCode = request_pin_info

    if respCode=="00"
      if @params[:pinStatus]=="001"
        coupon.update_attributes(:is_used => true)			# used
      elsif @params[:pinStatus]=="200"
        coupon.update_attributes(:is_expired => true)			# expired
      end
    end

    return respCode
  end


end

