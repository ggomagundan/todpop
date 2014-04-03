json.status @status
json.msg  @msg

json.data do |json|
  json.android_version  @android_version
  json.store_state  @store_state
  json.ment  @ment
end
