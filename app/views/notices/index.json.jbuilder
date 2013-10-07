json.array!(@notices) do |notice|
  json.extract! notice, :title, :content
  json.url notice_url(notice, format: :json)
end
