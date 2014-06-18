json.status @status
json.msg @msg

if @status == true
  json.words  @words
end
