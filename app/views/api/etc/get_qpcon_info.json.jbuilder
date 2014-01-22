json.status @status
json.msg @msg

if @status==true
  json.name @name
  json.place @place
  json.valid_start @valid_start
  json.valid_end @valid_end
  json.price @price
  json.bar_code @bar_code
  json.image @image
  json.information @information
end
