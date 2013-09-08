json.status @status
json.msg @msg

if @status == true
  json.data do |json|
    json.score @user_info do |w|
      json.array! w 
    end
    json.mine @mine
  end
end
