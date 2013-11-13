json.status @status
json.msg @msg

if @status == true
  json.data do |json|
    json.nickname @user.nickname
    json.recommend @user.recommend
    json.mem_id @user.id
    json.is_set_password  @user.is_set_facebook_password
  end
end
