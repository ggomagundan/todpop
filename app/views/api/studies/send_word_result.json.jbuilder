json.status @status
json.msg @msg

if @status == true
  json.data do |json|
   json.score  @score
   json.reward @reward
   json.medal @medal
   json.rank_point @rank_point
   json.a @a
  end

end
