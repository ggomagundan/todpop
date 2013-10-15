json.array!(@cpd_advertisements) do |cpd_advertisement|
  json.extract! cpd_advertisement, :kind, :count, :remain, :start_time, :end_time, :front_image, :back_image, :coupon_id
  json.url cpd_advertisement_url(cpd_advertisement, format: :json)
end
