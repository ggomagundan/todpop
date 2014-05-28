json.status @status
json.msg  @msg

if @status == true and @count.present?
  json.count  @count
  json.list @list
elsif @status == true and @reward.present?
  json.reward @reward
elsif @status == true and @point.present?
  json.point  @point
end
