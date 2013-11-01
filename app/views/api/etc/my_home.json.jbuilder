json.status @status
json.msg @msg

json.data do |json|
  json.prize           @prize
  json.my_level        @my_level
  json.my_rank         @my_rank
  json.attendance      @daily_test_count
  json.my_point        @my_point
  json.remain_point    @remain_to1st
  json.reward_today    @reward_today
  json.reward_current  @reward_current
  json.reward_total    @reward_total
end
