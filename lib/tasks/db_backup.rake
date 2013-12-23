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

    db_config = Rails.configuration.database_configuration
    user = db_config[Rails.env]['username']
    password = db_config[Rails.env]['password']
    database = db_config[Rails.env]['database']
    
    dest = Time.now.strftime('%Y-%m-%d')
    
    command = "mysqldump -u root"
    command += " -p!Xhemvkq*()" unless password.blank?
    command += " salty_production > db/backup/#{dest}.sql"
    system(command)
    #sh command
    #sh "mysqldump #{source} .dump > #{dest}"
  end
end

