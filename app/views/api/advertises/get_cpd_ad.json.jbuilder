json.status @status
json.msg @msg

if @status == true
  json.data do |json|
    json.type @ad_type
    json.front_image @content1
    json.back_image @content2
    json.coupon @coupon
  end
end
