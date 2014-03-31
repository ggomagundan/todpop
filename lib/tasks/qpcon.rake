require File.dirname(__FILE__) + '/../../config/environment.rb'
require 'open-uri'
require 'json'
require 'net/http'

#KEY = "0f8f5a7024dd11e3b5ae00304860c864"        # test key
#SERVER_IP = "211.245.169.201"			# test server
KEY = "1abc8aa2b65611e38f83001517d148e2"        # operation key
SERVER_IP = "211.233.60.195"			# operation server

#PRODUCT_PATH = "/home/cystein/qpcon" # test for cys local com
PRODUCT_PATH = "/todpop/todpop_data/qpcon" # link : /todpop/current/public/uploads
WEB_PATH = "http://www.todpop.co.kr/uploads/qpcon"

namespace :qpcon do

  # ---------------------------------------------------------------------------------------------------

  task :category => :environment do
    json = connect("cateList.do",{:cmd => "cateList"})
    if json["STATUS_CODE"] == "00"

      #ActiveRecord::Base.connection.execute("TRUNCATE qpcon_categories")
      cate_id = []
      category = QpconCategory.all

      json["CATEGORY"]["CATEGORY_LIST"].each do |list|
        QpconCategory.create(:category_id => list["CATE_ID"], :category_name => list["CATE_NAME"]) if !category.where('category_id = ?', list["CATE_ID"]).present?
        cate_id.push(list["CATE_ID"])
      end

      del_cate = QpconCategory.where('category_id not in (?)', cate_id)
      del_cate.each do |i|
        i.delete
      end
    end
  end

  # ---------------------------------------------------------------------------------------------------

  task :product_list => :environment do
    
    if !Dir.exist? PRODUCT_PATH
      Dir.mkdir PRODUCT_PATH
    end
    
    json = connect("prodList.do",{:cmd => "prodList"})

    if json["STATUS_CODE"] == "00"

      prod_id_list = []
      product = QpconProduct.all

      json["PRODUCT"]["PRODUCT_LIST"].each do |list|
        cate_id = list["CATE_ID"]
        prod_id = list["PROD_ID"]

        if !Dir.exist? "#{PRODUCT_PATH}/#{cate_id}"
          Dir.mkdir "#{PRODUCT_PATH}/#{cate_id}"
        end

        if !Dir.exist? "#{PRODUCT_PATH}/#{cate_id}/#{prod_id}"
          Dir.mkdir "#{PRODUCT_PATH}/#{cate_id}/#{prod_id}"
        end

        prod = product.find_by_product_id(list["PROD_ID"])
        if !prod.present?
          prod = QpconProduct.create(:product_id          => list["PROD_ID"],
                                     :qpcon_category_id   => list["CATE_ID"],
                                     :product_name        => list["PROD_NAME"],
                                     :change_market_name  => list["CHC_COMP_NAME"],
                                     :stock_count         => list["STOCK_CNT"].to_i,
                                     :market_cost         => list["MARKET_COST"].to_i,
                                     :common_cost         => list["COMMON_COST"].to_i)
        else
          prod.update_attributes(:product_id          => list["PROD_ID"],
                                 :qpcon_category_id   => list["CATE_ID"],
                                 :product_name        => list["PROD_NAME"],
                                 :change_market_name  => list["CHC_COMP_NAME"],
                                 :stock_count         => list["STOCK_CNT"].to_i,
                                 :market_cost         => list["MARKET_COST"].to_i,
                                 :common_cost         => list["COMMON_COST"].to_i)
        end
                                         
        prod.img_url_70   = "#{WEB_PATH}/#{cate_id}/#{prod_id}/#{File.basename list["IMG_URL_70"]}"
        prod.img_url_150  = "#{WEB_PATH}/#{cate_id}/#{prod_id}/#{File.basename list["IMG_URL_150"]}"
        prod.img_url_250  = "#{WEB_PATH}/#{cate_id}/#{prod_id}/#{File.basename list["IMG_URL_250"]}"

        prod.save!

        puts prod.img_url_70
        puts prod.img_url_150
        puts prod.img_url_250
 
        save_path = "#{PRODUCT_PATH}/#{cate_id}/#{prod_id}"
 
        [list["IMG_URL_70"],list["IMG_URL_150"],list["IMG_URL_250"]].each do |url|
          image_down url, save_path
          sleep 0.3
        end           # end of image down

        prod_id_list.push(list["PROD_ID"])
      end #json each end

      del_prod = QpconProduct.where('product_id not in (?)', prod_id_list)
      del_prod.each do |i|
        i.delete			# delete folder later
      end
    end               # json OK
  end #task

  # --------------------------------------------------------------------------------------------------------------------------------

  task :product_reload => :environment do
    QpconProduct.all.each do |product|
      json = connect("prodDetail.do",{:cmd => "prodDetail", :prodId => product.product_id})
      if json["STATUS_CODE"] == "00"

        detail = json["PRODUCT_DETAIL"]
        product.update_attributes(:qpcon_category_id => detail["CATE_ID"],
                                  :product_name => detail["PROD_NAME"],
                                  :change_market_name => detail["CHC_COMP_NAME"],
                                  :stock_count => detail["STOCK_CNT"],
                                  :market_cost => detail["MARKET_COST"],
                                  :common_cost => detail["COMMON_COST"],
                                  :market_name      => detail["MAKER"],
                                  :min_age          => detail["MIN_AGE"].to_i,
                                  :reg_dtm          => detail["REG_DTM"],
                                  :use_info         => detail["USE_INFO"],
                                  :valid_type       => detail["VALID_TYPE"].to_i,
                                  :valid_date       => detail["VALID_DATE"],
                                  :max_sale_cnt     => detail["MAX_SALE_CNT"].to_i,
                                  :min_sale_cnt     => detail["MIN_SALE_CNT"].to_i,
                                  :mon_max_sale_cnt => detail["MON_MAX_SALE_CNT"].to_i,
                                  :sale_gb          => detail["SALE_GB"].to_i,
                                  :pin_type         => detail["PIN_TYPE"].to_i,
                                  :prod_gb          => detail["PROD_GB"].to_i
                                 )
      end
    end
  end

  # ---------------------------------------------------------------------------------------------------

=begin
  task :product_send => :environment do
    json = pin_connect("pinIssue.do",{:prodId => QpconProduct.last.product_id,
                                      :reqOrdId => Time.now.to_datetime.strftime('%Y-%m-%d %H:%M:%S.%N') })
    puts json

  end
=end

  # ---------------------------------------------------------------------------------------------------

  task :pin_state => :environment do
    app_info = AppInfo.first
    fromDtm = app_info.pin_dtm.to_i
    #tmp = Time.now - 6.minute
    tmp = Time.now
    toDtm = tmp.strftime("%Y%m%d%H%M%S").to_i

    fromDtm = (tmp-1.day).strftime("%Y%m%d%H%M%S").to_i if fromDtm == nil

    response = connect("sendList.do",{:cmd => "sendList", :fromDtm => fromDtm, :toDtm => toDtm})
    
    response = response.split("\n")
    order = Order.where('is_used != 1 and is_expired != 1')

    response.each do |i|
      content = i.split('|')
      if (state = order.find_by_approval_number(content[0])).present?
        state.is_used = 1 if content[4]==400
        state.is_expired = 1 if content[4]==000
        state.save
      end
    end

    app_info.pin_dtm = (tmp-1).strftime("%Y%m%d%H%M%S").to_s
    app_info.save
  end

end

# 이미지 다운 로드
# 큐미폰 상품  이미지 다운을 위해 사용
def image_down(url, save_path)
  puts url
  file_name = File.basename(url)
  open("#{save_path}/#{file_name}", 'wb') do |file|
    file << open(url).read
  end
end

def connect(last_uri,params)
  uri = URI.parse("http://#{SERVER_IP}/qpcon/api/#{last_uri}")
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new(uri.request_uri)
  request.set_form_data(params.merge!({:key=> KEY}))
  @response = http.request(request)
  if last_uri == 'sendList.do'
    return @response.body
  else
    json = ActiveSupport::JSON.decode  Hash.from_xml(@response.body).to_json
    json = json["BIKINI"]
    return json
  end
end

=begin
def pin_connect(last_uri,params)
  uri = URI.parse("http://#{SERVER_IP}/qpcon/api/pin/#{last_uri}")
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new(uri.request_uri)
  request.set_form_data(params.merge!({:key=> KEY}))
  @response = http.request(request)
  return @response.body
end 
=end


=begin
  task :product_list => :environment do
    if !Dir.exist? PRODUCT_PATH
      Dir.mkdir PRODUCT_PATH
    end

    QpconCategory.all.each do |c_id|
      json = connect("prodList.do",{:cmd => "prodList", :cateId => c_id.category_id})
      if json["STATUS_CODE"] == "00"
        if !Dir.exist? "#{PRODUCT_PATH}/#{c_id.category_id}"
          Dir.mkdir "#{PRODUCT_PATH}/#{c_id.category_id}"
        end
        json["PRODUCT"]["PRODUCT_LIST"].each do |list|
          prod_id = list["PROD_ID"]
          if !Dir.exist? "#{PRODUCT_PATH}/#{c_id.category_id}/#{prod_id}"
            Dir.mkdir "#{PRODUCT_PATH}/#{c_id.category_id}/#{prod_id}"
          end

          if QpconProduct.where(:product_id => list["PROD_ID"]).present?
            coupon = QpconProduct.where(:product_id => list["PROD_ID"]).first
            coupon.update_attributes(:product_name       => list["PROD_NAME"], 
                                      :qpcon_category_id  => c_id.id,                                  # <---------- why just id? rather than category_id
                                      :change_market_name => list["CHC_COMP_NAME"], 
                                      :stock_count        => list["STOCK_CNT"].to_i,
                                      :market_cost        => list["MARKET_COST"].to_i,
                                      :common_cost        => list["COMMON_COST"].to_i
                                      )
                                      
            coupon.img_url_70   = "#{WEB_PATH}/#{c_id.category_id}/#{prod_id}/#{File.basename list["IMG_URL_70"]}"
            coupon.img_url_150  = "#{WEB_PATH}/#{c_id.category_id}/#{prod_id}/#{File.basename list["IMG_URL_150"]}"
            coupon.img_url_250  = "#{WEB_PATH}/#{c_id.category_id}/#{prod_id}/#{File.basename list["IMG_URL_250"]}"
            
            puts coupon.img_url_70
            puts coupon.img_url_150
            puts coupon.img_url_250

            save_path = "#{PRODUCT_PATH}/#{c_id.category_id}/#{prod_id}"
            
            [list["IMG_URL_70"],list["IMG_URL_150"],list["IMG_URL_250"]].each do |url|
              image_down url, save_path
              sleep 0.3
            end

            coupon.save!
          else
            coupon = QpconProduct.create(:product_id          => list["PROD_ID"], 
                                         :product_name        => list["PROD_NAME"],
                                         :qpcon_category_id   => c_id.id,
                                         :change_market_name  => list["CHC_COMP_NAME"],
                                         :stock_count         => list["STOCK_CNT"].to_i,
                                         :market_cost         => list["MARKET_COST"].to_i,
                                         :common_cost         => list["COMMON_COST"].to_i
                                         )
                                         
            coupon.img_url_70   = "#{WEB_PATH}/#{c_id.category_id}/#{prod_id}/#{File.basename list["IMG_URL_70"]}"
            coupon.img_url_150  = "#{WEB_PATH}/#{c_id.category_id}/#{prod_id}/#{File.basename list["IMG_URL_150"]}"
            coupon.img_url_250  = "#{WEB_PATH}/#{c_id.category_id}/#{prod_id}/#{File.basename list["IMG_URL_250"]}"

            puts coupon.img_url_70
            puts conpon.img_url_150
            puts coupon.img_url_250
            
            save_path = "#{PRODUCT_PATH}/#{c_id.category_id}/#{prod_id}"
            
            [list["IMG_URL_70"],list["IMG_URL_150"],list["IMG_URL_250"]].each do |url|
              image_down url, save_path
              sleep 0.3
            end
          coupon.save!
          end
        #product_id:string qpcon_category_id:integer product_name:string change_market_name stock_count:integer market_cost:integer common_cost:integer img_url_70:string img_url_150:string img_url_250:string market_name:string min_age:integer use_info:text valid_type:integer valid_date:string max_sale:integer min_sale:integer max_month_sale:integer is_sale:integer pin_type:integer product_type:integer

        end
      end
    end
  end
=end



