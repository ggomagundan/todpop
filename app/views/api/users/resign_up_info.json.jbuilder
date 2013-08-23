json.status @status
json.msg @msg

if @status == true
  json.data do |json|
    json.nickname @user.nickname
    json.recommend @user.recommend
    json.mem_id @user.id

  end
end
