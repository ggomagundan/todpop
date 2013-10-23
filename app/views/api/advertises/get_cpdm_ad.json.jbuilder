json.status @status
json.msg @msg

if @status == true
  json.data do |json|
    json.ad_id @ad_id
    json.ad_type  @ad_type
    json.url @url
    json.length @length
  end
end
