json.status @status
json.msg @msg
json.data do |json|
  json.ment @ment
  json.android_url @android_url
  json.ios_url @ios_url
end
