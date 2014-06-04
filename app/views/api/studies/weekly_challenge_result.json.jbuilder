json.status @status
json.msg  @msg

if @status == true
  json.score  @score
end
