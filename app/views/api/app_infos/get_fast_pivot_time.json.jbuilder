json.status @status
json.msg @msg

if @status == true
  json.data do |json|
    json.(@pivot, :time_quick_ans)
  end
end
