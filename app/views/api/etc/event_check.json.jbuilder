json.status @status
json.msg  @msg

if @status == true
  json.value @value
end
