namespace :db do
  desc "Backup the salty_production database"
  task :backup => :environment do
    backup_dir = ENV['DIR'] || File.join(Rails.root, 'db', 'backup')

=begin
    source = File.join(Rails.root, 'db', "production.db")
    dest = File.join(backup_dir, "#{Time.now.strftime('%Y-%m-%d')}.sql")
    dest = File.join(backup_dir, "production.backup")
    dest = "#{Time.now.strftime('%Y-%m-%d')}.sql"
=end
    makedirs backup_dir, :verbose => true
    dest = Time.now.strftime('%Y-%m-%d')
    sh "mysqldump -u root -p salty_production > #{dest}.sql"
    sh "!Xhemvkq*()"
    #sh "mysqldump #{source} .dump > #{dest}"
  end
end

