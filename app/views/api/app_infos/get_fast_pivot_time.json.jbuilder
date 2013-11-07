json.status @status
json.msg @msg

if @status == true
  json.data do |json|
    json.time  @time
  end
end
