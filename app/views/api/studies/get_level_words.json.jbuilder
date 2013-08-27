json.status @status
json.msg @msg

if @status == true
  json.data @word do |w|
    json.array! w.word 
  end

end
