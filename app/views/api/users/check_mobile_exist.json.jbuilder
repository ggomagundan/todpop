json.status @status
json.msg @msg

if @status == true
  json.data do |json|
      json.(@user, :email, :facebook, :mobile, :level_test)
  end
end
