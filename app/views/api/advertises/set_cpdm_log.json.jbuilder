json.status @status
json.msg @msg

if @status == true
  json.data do |json|
    json.result @result
  end
end