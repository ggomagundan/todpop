if @status == true

  json.status @status
  json.msg @msg
  json.data do |json|
    json.result @dupli
  end
else
  json.status @status
  json.msg @msg
end
