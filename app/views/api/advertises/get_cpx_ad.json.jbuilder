json.status @status
json.msg @msg

if @status == true
  json.data do |json|
    json.ad_id @ad_id
    json.ad_type @ad_type
    json.url @url
    json.ad_image @ad_image
    json.ad_text @ad_text
    json.store_url @store_url
    json.confirm_url @confirm_url
    json.reward @reward
    json.n_question @n_question
  end
end
