json.status @status
json.msg @msg

if @status == true
  json.data do |json|
      json.array!(@list, :title, :sub_title, :reward_point, :reward_type, :created_at)  

  end
end



