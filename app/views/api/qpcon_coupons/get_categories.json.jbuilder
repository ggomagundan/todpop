json.status @status
json.msg @msg

json.data do |json|
 json.array! @category 
end
