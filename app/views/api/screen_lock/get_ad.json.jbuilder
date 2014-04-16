json.status @status
json.msg @msg

if @status == true
  json.data do |json|
    json.ad_id @ad_id
    json.ad_type @ad_type
    json.ad_image @ad_image
    json.target_url @target_url
    json.reward @reward
    json.point @point
  end
end
