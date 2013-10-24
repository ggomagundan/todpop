json.status @status
json.msg @msg

if @status == true
  json.data do |json|
    json.current @current
    json.content @content
  end
end

