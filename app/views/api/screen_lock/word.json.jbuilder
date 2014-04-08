json.status @status
json.msg  @msg

if @status==true
  json.data do |json|
    json.word @word
    json.mean @mean
  end
end
