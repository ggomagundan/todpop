json.status @status
json.msg @msg

if @status == true
  json.data do |json|
    json.ad_no @ad_no
    json.content1 @content1
    json.content2 @content2
  end
end
