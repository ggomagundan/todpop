json.status @status
json.msg  @msg

json.data do |json|
  json.android_version  @android_version
  json.major_version  @major_version
  json.store_state  @store_state
  json.ment  @ment
  json.ment_arr @ment_arr
end
