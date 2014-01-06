json.status @status
json.msg @msg

if @status == true

  if @word.present?
    wdata = []
    @word.each do |w|
      wt = w.word
      wdata.push({id:wt.id, name:wt.name, mean:wt.mean, example_en:wt.example_en, example_ko:wt.example_ko, phonetics:wt.phonetics, picture:wt.picture, image_url:wt.image_url(:thumb)})
    end
    json.data wdata
  end

  if @spare.present?
    sdata = []
    @spare.each do |w|
      wt = w.word
      sdata.push({id:wt.id, name:wt.name, mean:wt.mean, example_en:wt.example_en, example_ko:wt.example_ko, phonetics:wt.phonetics, picture:wt.picture, image_url:wt.image_url(:thumb)})
    end
    json.spare sdata
  end

end

