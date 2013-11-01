json.status @status
json.msg @msg

json.data do |json|
  json.product    @prize
  json.level      @my_level
  json.my_rank    @my_rank
  json.attendance @daily_test_count
  json.point      @my_point
  json.remain     @remain_to1st
  json.today      @reward_today
  json.reward     @reward_current
  json.sum        @reward_total
end
