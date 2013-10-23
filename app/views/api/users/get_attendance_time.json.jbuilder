json.status @status
json.msg @msg

if @status == true
  json.data do |json|

    json.attendance_time @attendance_time
  end
end



