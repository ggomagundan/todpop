json.status @status
json.msg  @msg

if @status == true
  json.test @test
end
