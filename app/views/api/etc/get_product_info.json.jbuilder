json.status @status
json.msg @msg

if @status==true
  json.data do |json|
    json.image @image
    json.content1 @content1
    json.content2 @content2
    json.content3 @content3
  end
end
