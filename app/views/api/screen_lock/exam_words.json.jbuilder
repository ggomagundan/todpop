json.status @status
json.msg  @msg

if @status == true
  json.list @list
end
