json.status @status
json.msg @msg

if @status == true
  json.data do |json|
      json.array!(@list, :reward_type, :title, :sub_title, :reward, :created_at)  

  end
end



