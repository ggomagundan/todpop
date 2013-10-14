json.status @status
json.msg @msg

if @status == true
  json.data do |json|
  	json.url @data_url
  	json.num @length
  end
end