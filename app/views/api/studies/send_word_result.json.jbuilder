json.status @status
json.msg @msg

if @status == true
  json.data do |json|
   json.score  @score
   json.reward @reward
   json.medal @medal
   json.rank_point @rank_point
   json.attend_reward @attend_reward
   json.attend_point  @attend_point
   json.stage_info @stage_info
  end

end
