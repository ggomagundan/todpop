json.status @status
json.msg @msg

if @status == true
  if !@list.present?
  json.data do |json|
    json.ad_id        @ad_id
    json.ad_type      @ad_type
    json.history      @history
    json.video_ver    @video_ver
    json.url          @url
    json.length       @length

    json.reward       @reward
    json.point       @point

    json.name         @name
    json.caption      @caption
    json.description  @description
    json.link         @link
    json.picture      @picture
    json.skip         @skip
  end
  else
    json.ad_list  @ad_list
  end
end
