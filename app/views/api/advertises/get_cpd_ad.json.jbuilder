json.status @status
json.msg @msg

if @status == true
  json.data do |json|
    json.ad_id        @ad_id
    json.ad_type      @ad_type
    json.history      @history
    json.front_image  @content1
    json.back_image   @content2
    json.coupon       @coupon

    json.reward       @reward
    json.point        @point

    json.name         @name
    json.caption      @caption
    json.description  @description
    json.link         @link
    json.picture      @picture
  end
end
