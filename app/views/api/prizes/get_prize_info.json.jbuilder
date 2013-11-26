json.status @status
json.msg @msg

if @status==true

  send = []
  d = @info
  send = {id:d.id, name:d.name, category:d.category, period:d.period, rank:d.rank, date_start:d.date_start, date_end:d.date_end, image_url:d.image_url(:thumb), content1:d.content1, content2:d.content2, content3:d.content3}

  json.data send

end

