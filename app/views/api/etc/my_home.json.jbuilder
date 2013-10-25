json.status @status
json.msg @msg

json.data do |json|
  json.product @product   ##nickname:현재랭커 필요
  json.level @level
  json.rank @rank   ##Not Yet
  json.attendance @attendance
  json.point @point   ##Not Yet
  json.remain @remain ##Not Yet
  json.today @today
  json.reward @reward
  json.sum @sum
end
