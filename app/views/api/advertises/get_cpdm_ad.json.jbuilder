json.status @status
json.msg @msg

if @status == true
  json.data do |json|
    json.ad_id        @ad_id
    json.ad_type      @ad_type
    json.url          @url
    json.length       @length

    json.reward       @reward
    json.point       @point

    json.name         @name
    json.caption      @caption
    json.description  @description
    json.link         @link
    json.picture      @picture
  end
end
