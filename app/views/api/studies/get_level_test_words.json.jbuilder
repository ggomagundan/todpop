json.status @status
json.msg @msg

if @status == true
  json.data do |json|
    json.word @c_word.name
    json.mean @c_word.mean 
    json.wrong @wrong_word
    if @level.present?
      json.level @level
    end
  end
end
