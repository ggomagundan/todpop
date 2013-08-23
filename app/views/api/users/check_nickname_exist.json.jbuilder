json.status @status
json.msg @msg

if @status == true
  json.status @status
  json.msg @msg
  
  json.data do |json|
    json.result @result
  end

end
