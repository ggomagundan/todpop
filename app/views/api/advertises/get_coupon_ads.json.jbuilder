json.status @status
json.msg @msg

if @status == true
  json.data do |json|
    json.ad_no @ad_no
    json.front_image @content1
    json.back_image @content2
    json.back_title @title
    json.back_subtitle @subtitle
    json.back_content @content
    json.back_original_price @original_price
    json.back_discount_price @discount_price
    json.back_desc @desc
    json.bacj_subdesc @subdesc
    json.coupon_id @coupon_id
  end
end
