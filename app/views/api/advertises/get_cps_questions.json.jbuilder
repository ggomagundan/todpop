json.status @status
json.msg @msg

if @status == true
  json.data do |json|
    json.array! @q_array
  end
end
