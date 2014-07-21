json.status @status
json.msg @msg
json.data do |json|
  json.ment @ment
  json.img_url @img_url
  json.img_width @img_width
  json.img_height @img_height
  json.android_url @android_url
  json.ios_url @ios_url
end
