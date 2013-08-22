json.array!(@users) do |user|
  json.extract! user, :email, :facebook, :password, :nickname, :recommend, :sex, :birth, :address, :mobile, :date, :late_connection, :level_test
  json.url user_url(user, format: :json)
end
