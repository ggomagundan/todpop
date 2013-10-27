json.status @status
json.msg @msg

if @status == true
  json.data do |json|
    json.current_reward @current_reward
    json.content @content
  end
end

