json.status @status
json.msg @msg

if @status == true
  json.data do |json|
   json.score  @score
   json.reward @reward
   json.medal @medal
  end

end
