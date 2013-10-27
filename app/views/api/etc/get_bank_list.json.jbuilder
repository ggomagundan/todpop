json.status @status
json.msg @msg

if @status == true
  json.data do |json|
    json.bank_list (@bank_list)
  end

end
