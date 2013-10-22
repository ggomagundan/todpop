json.status @status
json.msg @msg

if @status == true
  json.data do |json|
    json.is_set @set_password
  end
end
