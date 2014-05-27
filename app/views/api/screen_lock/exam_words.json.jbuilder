json.status @status
json.msg  @msg

if @status == true and @count.present?
  json.count  @count
  json.list @list
end
