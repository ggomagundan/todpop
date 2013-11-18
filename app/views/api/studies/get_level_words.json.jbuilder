json.status @status
json.msg @msg

if @status == true
  send = []
  @word.each do |w|
    wt = w.word
    send.push({id:wt.id, name:wt.name, mean:wt.mean, example_en:wt.example_en, example_ko:wt.example_ko, phonetics:wt.phonetics, picture:wt.picture, image_url:wt.image_url(:thumb)})
  end

  json.data send
end
