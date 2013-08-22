# -*- encoding : utf-8 -*-
json.status @status
json.msg @msg

if @status == true
  json.data do |json|
    json.mem_id @user.id
    json.email @user.email
    json.facebook @user.facebook
    json.nickname @user.nickname
    json.level_test @uest.level_test
  end
end
