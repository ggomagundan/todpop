json.status @status
json.msg @msg

if @status == true
  json.data do |json|
    json.id @ad_id
    json.type  @ad_type
    json.url @url
  end
end
