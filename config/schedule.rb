# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever


every 1.day, :at => '00:01am' do
  rake "ads:cpd_priorities", :output => "log/change_ads_priority.log", :environment => ENV['RAILS_ENV']
end

every 1.day, :at => '00:03am' do
  rake "ads:cpdm_priorities", :output => "log/change_ads_priority.log", :environment => ENV['RAILS_ENV']
end

every 1.day, :at => '00:05am' do
  rake "ads:cpx_priorities", :output => "log/change_ads_priority.log", :environment => ENV['RAILS_ENV']
end

every 1.day, :at => '04:00am' do
  rake "db:backup", :output => "log/db_backup.log", :environment => ENV['RAILS_ENV']
end

every 30.minute do
  rake "db:rank", :output => "log/rank_temp.log", :environment => ENV['RAILS_ENV']
end

every 1.day, :at => '03:00am' do
  rake "qpcon:category", :output => "log/qpcon.log", :environment => ENV['RAILS_ENV']
end

every 1.day, :at => '03:10am' do
  rake "qpcon:product_list", :output => "log/qpcon.log", :environment => ENV['RAILS_ENV']
end

every 1.day, :at => '03:20am' do
  rake "qpcon:product_reload", :output => "log/qpcon.log", :environment => ENV['RAILS_ENV']
end
