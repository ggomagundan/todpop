json.status @status
json.msg  @msg

if @status == true
  json.data do |json|
    json.ad_id  @ad_id
    json.ad_type  @ad_type
    json.ad_image @ad_image
    json.ad_text  @ad_text
    json.target_url @target_url
    json.package_name @package_name
    json.confirm_url  @confirm_url
    json.reward @reward
    json.n_question = @n_question
  end
end
