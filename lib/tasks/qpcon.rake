require File.dirname(__FILE__) + '/../../config/environment.rb'
   
  KEY = "0f8f5a7024dd11e3b5ae00304860c864"

  namespace :qpcon do
    task :category => :environment do
      json = connect("cateList.do","cateList")
      if json["STATUS_CODE"] == "00"
        json["CATEGORY"]["CATEGORY_LIST"].each do |list|
          if QpconCategory.where(:category_id => list["CATE_ID"]).blank?
            QpconCategory.create(:category_id => list["CATE_ID"], :category_name => list["CATE_NAME"])
          end
        end
      end
    end
  end


  def connect(last_uri,cmd) 
      uri = URI.parse("http://211.245.169.201/qpcon/api/cateList.do")
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data({:key=> KEY, :cmd=>cmd})
      @response = http.request(request)
      json = ActiveSupport::JSON.decode  Hash.from_xml(@response.body).to_json
      json = json["BIKINI"]
      return json
  end

