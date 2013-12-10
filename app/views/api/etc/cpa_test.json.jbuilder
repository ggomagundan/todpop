json.status @status
json.msg  @msg

if @status == true
  json.data do |json|
    json.action_date  @action_date
    json.action_time  @action_time
  end
end
