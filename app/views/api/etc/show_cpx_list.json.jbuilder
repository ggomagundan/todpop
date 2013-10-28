json.status @status
json.msg @msg

if @status == true
  json.data @cpx_list
end
