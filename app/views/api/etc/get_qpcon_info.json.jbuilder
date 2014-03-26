json.status @status
json.msg @msg

if @status==true
  json.category_id @category_id
  json.product_id @product_id
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
  json.veri_numid @admit_id
  json.is_used @is_used
  json.is_expired @is_expired
end
