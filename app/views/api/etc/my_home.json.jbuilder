json.status @status
json.msg @msg

json.data do |json|
  json.product @product
  json.level @level
  json.attendance @attendance
end
