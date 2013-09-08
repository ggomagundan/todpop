json.status @status
json.msg @msg

if @status == true
  json.data do |json|
    json.ad_no @ad_no
    json.front_image @content1
    json.back_image @content2
  end
end
