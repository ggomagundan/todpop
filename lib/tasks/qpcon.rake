
require File.dirname(__FILE__) + '/../../config/environment.rb'
require 'open-uri'
require 'json'
require 'net/http'

KEY = "0f8f5a7024dd11e3b5ae00304860c864"
PRODUCT_PATH = "/todpop/todpop_data/qpcon" # link : /todpop/current/public/uploads
WEB_PATH = "http://www.todpop.co.kr/uploads/qpcon"

namespace :qpcon do

  task :category => :environment do
    json = connect("cateList.do",{:cmd => "cateList"})
    if json["STATUS_CODE"] == "00"
      json["CATEGORY"]["CATEGORY_LIST"].each do |list|
        if QpconCategory.where(:category_id => list["CATE_ID"]).blank?
          QpconCategory.create(:category_id => list["CATE_ID"], :category_name => list["CATE_NAME"])
        end
      end
    end
  end

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
                                      :qpcon_category_id  => c_id.id, 
                                      :change_market_name => list["CHC_COMP_NAME"], 
                                      :stock_count        => list["STOCK_CNT"].to_i, 
                                      :market_cost        => list["MARKET_COST"].to_i, 
                                      :common_cost        => list["COMMON_COST"].to_i
                                      )
                                      
            coupon.remote_img_url_70_url   = "#{WEB_PATH}/#{c_id.category_id}/#{prod_id}/#{File.basename list["IMG_URL_70"]}"
            coupon.remote_img_url_150_url  = "#{WEB_PATH}/#{c_id.category_id}/#{prod_id}/#{File.basename list["IMG_URL_150"]}"
            coupon.remote_img_url_250_url  = "#{WEB_PATH}/#{c_id.category_id}/#{prod_id}/#{File.basename list["IMG_URL_250"]}"

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
                                         
            coupon.remote_img_url_70_url   = "#{WEB_PATH}/#{c_id.category_id}/#{prod_id}/#{File.basename list["IMG_URL_70"]}"
            coupon.remote_img_url_150_url  = "#{WEB_PATH}/#{c_id.category_id}/#{prod_id}/#{File.basename list["IMG_URL_150"]}"
            coupon.remote_img_url_250_url  = "#{WEB_PATH}/#{c_id.category_id}/#{prod_id}/#{File.basename list["IMG_URL_250"]}"

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

  task :product_reload => :environment do
    QpconProduct.all.each do |product|
      json = connect("prodDetail.do",{:cmd => "prodDetail", :prodId => product.product_id})
      if json["STATUS_CODE"] == "00"

        detail = json["PRODUCT_DETAIL"]
        product.update_attributes(:stock_count    => detail["STOCK_CNT"].to_i, 
                                  :market_cost    => detail["MARKET_COST"].to_i, 
                                  :common_cost    => detail["COMMON_COST"].to_i, 
                                  :img_url_70     => detail["IMG_URL_70"], 
                                  :img_url_150    => detail["IMG_URL_150"], 
                                  :img_url_250    => detail["IMG_URL_250"], 
                                  :info           => detail["USE_INFO"])

      end
    end
  end

  task :product_send => :environment do
    json = pin_connect("pinIssue.do",{:prodId => QpconProduct.last.product_id,
                                      :reqOrdId => Time.now.to_datetime.strftime('%Y-%m-%d %H:%M:%S.%N') })
    puts json

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
  uri = URI.parse("http://211.245.169.201/qpcon/api/#{last_uri}")
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new(uri.request_uri)
  request.set_form_data(params.merge!({:key=> KEY}))
  @response = http.request(request)
  json = ActiveSupport::JSON.decode  Hash.from_xml(@response.body).to_json
  json = json["BIKINI"]
  return json
end

def pin_connect(last_uri,params)
  uri = URI.parse("http://211.245.169.201/qpcon/api/pin/#{last_uri}")
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new(uri.request_uri)
  request.set_form_data(params.merge!({:key=> KEY}))
  @response = http.request(request)
  return @response.body
end 
