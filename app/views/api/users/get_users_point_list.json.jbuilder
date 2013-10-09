# -*- encoding : utf-8 -*-
json.status @status
json.msg @msg

if @status == true
  json.data do |json|
    json.points @point
  end
end
