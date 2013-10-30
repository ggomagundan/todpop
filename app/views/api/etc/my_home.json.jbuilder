json.status @status
json.msg @msg

json.data do |json|
  json.product @product
  json.level @level
  json.my_rank @my_rank
  json.attendance @attendance
  json.point @point
  json.remain @remain
  json.today @today
  json.reward @reward
  json.sum @sum
end
