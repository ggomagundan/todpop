namespace :db do
  desc "Backup the salty_production database"
  task :backup => :environment do
    backup_dir = ENV['DIR'] || File.join(Rails.root, 'db', 'backup')

    makedirs backup_dir, :verbose => true

    db_config = Rails.configuration.database_configuration
    user = db_config[Rails.env]['username']
    #password = db_config[Rails.env]['password']
    password = "!Xhemvkq*()"
    database = db_config[Rails.env]['database']
    
    dest = Time.now.strftime('%Y-%m-%d-%H-%M')
    
    command = "mysqldump -u root"
    command += " -p\'#{password}\'" unless password.blank?
    command += " salty_production > db/backup/#{dest}.sql"
    
    sh command
  end
end

