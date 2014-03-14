class QpconManager
  PRODUCT_END_POINT = {
    :issue_pin                => "http://211.233.60.195/qpcon/api/pin/pinIssue.do",
    :pin_issue_confirm        => "http://211.233.60.195/qpcon/api/pin/pinIssueConfirm.do",
    :pin_cancle               => "http://211.233.60.195/qpcon/api/pin/pinCancel.do",
    :pin_issue_result         => "http://211.233.60.195/qpcon/api/pin/pinIssueResult.do",
    :pin_info                 => "http://211.233.60.195/qpcon/api/pin/pinInfo.do"
  }

  TEST_END_POINT = {
    :issue_pin                => "http://211.245.169.201/qpcon/api/pin/pinIssue.do",
    :pin_issue_confirm        => "http://211.245.169.201/qpcon/api/pin/pinIssueConfirm.do",
    :pin_cancle               => "http://211.245.169.201/qpcon/api/pin/pinCancel.do",
    :pin_issue_result         => "http://211.245.169.201/qpcon/api/pin/pinIssueResult.do",
    :pin_info                 => "http://211.245.169.201/qpcon/api/pin/pinInfo.do"
  }

  AUTH_KEY = {
    :product_key              => "aaaaaaa",
    :test_key                 => "0f8f5a7024dd11e3b5ae00304860c864"
  }

  attr_accessor :key,
                  :end_point,
                  :status,
                  :request_params,
                  :respons_params,
                  :user,
                  :coupon

  # mode == 0 : 운영 모드
  # mode == 1 : 개발 모드

  def initialize(mode = 0)
    if mode == 1
      @key = AUTH_KEY[:product_key]
      @end_point = PRODUCT_END_POINT
    else
      @key = AUTH_KEY[:test_key]
      @end_point = TEST_END_POINT
    end

    # staus 가 0 일 경우, 빈 발행 요청부터 핀 확정까지 진행되는 프로세스임
    @status = 0
    @request_params = {}
    @response_params = {}
  end

  def add_deault_params ()
    @request_params[:key] = key
  end

  # Pin 발행을 요청
  def request_issue_pin(user, coupon)
    @user = user
    @coupon = coupon

    add_default_params
    set_issue_pin_params(user, coupon)
    response = request(@end_point[:issue_pin])
    @response_params = parse_issue_pin_response(response)

    result = false;

    if @response_params[:respCode] == "00"
      #일반 상품 핀 발행  성공 , 확정 api 호출
      result = request_conform_pin
      if result
      return true
      else
        request_cancel_pin
      return false
      end
    end

    # 연동 상품 핀 발행  ,상품 조회 api와 핀 확정 api 호출
    if @response_params[:respCode]=="10"
      sleep 1
      result = request_pin_issue_result

      if !result
        cnt = 2
        while result == false && cnt>0
          sleep(1)
          result = request_pin_issue_result
          cnt = cnt-1
        end

        if !result
        return false
        else
          result = request_confirm_pin
          if !result
            request_cancel_pin
          return false
          else return true
          end
        end
      else
        result = request_conform_pin
        if !result
          request_cancel_pin
        return false
        else
        return true
        end
      end
    end

    # 이외의 상황은 응답코드 00,10 이외의 상황으로 핀 발행 요청이   명시적 실패한 경우임
    # 응답 값 미수신시 재 발행요청을 할 수도 있고, 내부적으로 취소 처리 할 수도 있음
    # 핀 발행 요청에 대해서 재 요청을 할 경우 이 곳에 코드 작성
    # 혀재는 발생요청 실패 후에 재 발행 요청은 하지 않음.
    if  @response_params[:respCode] != "00" && @response_params[:respCode] != "10"
    return false
    end

    return false
  end

  def set_issue_pin_params(user, coupon)
    timenow = Time.now.to_datetime
    @request_params[:reqOrdId]  = user.id.to_s + '_' + timenow.strftime('%Y%m%d') + '_' + timenow.strftime('%H%M%S') + '_' + timenow.strftime('%N')
    @request_params[:prodId]    = coupon.product_id
    @request_params[:pinCnt]    = 1
    @request_params[:payGb]     = nil
    @request_params[:reserved1] = nil
    @request_params[:reserved2] = nil
  end

  #핀 발행 요청
  def request_pin_issue_result
    params = {}
    params[:key]          = key
    params[:reqOrdId]     = @request_params[:reqOrdId]
    params[:prodId]       = @request_params[:prodId]
    params[:reserved1]    = nil
    params[:reserved2]    = nil

    response = request(end_point[:pin_issue_result], params)
    params.clear
    params = parse_issue_result_res(response)

    if params[:resdCode] != "00" || params.nil? || params.empty?
    return false
    end
  end

  #핀 발행에 대하여 확정 요청
  def request_confirm_pin
    params = {}
    params[:key] = key
    params[:admitId] = @response_params[:admitId]

    response = request(end_point[:pin_issue_confirm],params)
    params = parse_confirm_pin_res(respone)

    if params[:respCode] !="00" || params.nil? || params.empty?
    return false
    else
    return true
    end
  end

  #핀 발생 취소 요청
  def request_cancel_pin params = nil
    cancel_params = {}
    cancel_params[:key] = key

    # params == nil : 핀 발행 요청 과정에서 실패로 인한 취소 이며
    # params != nil : 유저가  직접 취소한 경우임
    if params.nil?
      cancel_params[:admitId] = @response_params[:admitId]
      cancel_params[:pinNum]  = @response_params[:pinNum]
      cancel_params[:reserved1] = nil
      cancel_params[:reserved2] = nil
    else
    cancel_params = params
    end

    request(end_point[:pin_cancle],cancel_params)
  end

  def parse_issue_result_res response
    params = {}
    response_splist = response.split("|")
    params[:respCode]   = resposne_split[0]
    params[:respMsg]    = resposne_split[1]
    params[:reqOrdId]   = response_split[2]
    params[:pinNum]     = response_split[3]
    params[:validDate]  = response_split[4]
    params[:admitId]    = response_split[5]
    params[:issueDate]  = response_split[6]
    return params
  end

  #핀 확정 요청에 대한 응답의 파싱
  def parse_confirm_pin_res (response)
    params = {}
    response_split = response.split("|")
    params[:respCode] = response_split[0]
    params[:respMsg]  = response_aplit[1]
    return params
  end

  #핀 발행 요청 에 대한 응답 파싱
  def parse_issue_pin_response (response)
    response_split = response.split("|")
    @responss_params[:respCode]   = response_split[0]
    @responss_params[:respMsg]    = response_split[1]
    @responss_params[:reqOrdId]   = response_split[2]
    @responss_params[:pinNum]     = response_split[3]
    @responss_params[:validDate]  = response_split[4]
    @responss_params[:admitId]    = response_split[5]
    @responss_params[:issueDate]  = response_split[6]
  end

  # 실제 연결하여 응답을 가져오는 함수
  def request (url,params = nil)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data( params ? params : @request_params)
    response_string = http.request(request)
    return response_string.body
  end

  def requet_pin_info(admitId,pinNum)
    info_params ={}
    info_params[:key] = key
    info_params[:admitId] = admitId
    info_params[:reserved1] = nil
    info_params[:reserved2] = nil

    response_string = request(end_point[:pin_info],info_params)
    return parse_pin_info(response_string)
  end

  def parse_pin_info(response)
    respone_split = response.split("|")
    response_params = {}
    response_params[:respCode]     = response_split[0]
    response_params[:respMsg]      = response_split[1]
    response_params[:reqOrdId]     = response_split[2]
    response_params[:issueDate]    = response_split[3]
    response_params[:admitId]      = response_split[4]
    response_params[:pinStatus]    = response_split[5]
    response_params[:useDate]      = response_split[6]
    response_params[:cancelDate]   = response_split[7]
    response_params[:validDate]    = response_split[8]
    return response_params
  end
end

