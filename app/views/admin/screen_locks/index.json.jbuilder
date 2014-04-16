json.array!(@admin_screen_locks) do |admin_screen_lock|
  json.extract! admin_screen_lock, 
  json.url admin_screen_lock_url(admin_screen_lock, format: :json)
end
