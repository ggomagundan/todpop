json.status @status
json.msg @msg

if @status==true
  json.data @info
end

