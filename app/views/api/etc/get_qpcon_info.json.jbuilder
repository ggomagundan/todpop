json.status @status
json.msg @msg

if @status==true
  json.name @name
  json.maker @maker
  json.maker_logo_url @maker_logo_url
  json.price @price
  json.place @place
  json.image @image
  json.information @information
  json.valid_duration @valid_duration
  json.valid_start @valid_start
  json.valid_end @valid_end
  json.bar_code @bar_code
  json.admit_id @admit_id
  json.is_used @is_used
  json.is_expired @is_expired
end
