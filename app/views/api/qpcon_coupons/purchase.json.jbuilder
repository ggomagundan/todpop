json.status @status
json.msg @msg

if @status == true
  json.result @result
  json.return_msg @return_msg
end
