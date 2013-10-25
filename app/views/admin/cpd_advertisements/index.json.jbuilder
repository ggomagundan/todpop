json.array!(@cpd_advertisements) do |cpd_advertisement|
  json.extract! cpd_advertisement, :ad_type, :contract, :remain, :start_date, :end_date, :front_image, :back_image, :coupon_id
  json.url cpd_advertisement_url(cpd_advertisement, format: :json)
end
