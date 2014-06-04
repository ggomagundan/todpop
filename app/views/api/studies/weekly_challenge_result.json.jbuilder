json.status @status
json.msg  @msg

if @status == true
  json.last_point @last_point
  json.current_point  @current_point
  json.score  @score
end
