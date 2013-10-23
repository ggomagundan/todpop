json.status @status
json.msg @msg

if @status == true
  json.data do |json|
    json.ad_id @ad_id
    json.ad_type @ad_type
    json.front_image @content1
    json.back_image @content2
    json.coupon @coupon
  end
end
