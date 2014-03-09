namespace :db do
  desc "Backup the salty_production database"
  task :backup => :environment do
    backup_dir = ENV['DIR'] || File.join(Rails.root, 'backup')

    makedirs backup_dir, :verbose => true

    db_config = Rails.configuration.database_configuration
    user = db_config[Rails.env]['username']
    #password = db_config[Rails.env]['password']
    password = "!Xhemvkq*()"
    database = db_config[Rails.env]['database']
    
    dest = Time.now.strftime('%Y-%m-%d-%H-%M')
    
    command = "mysqldump -u root"
    command += " -p\'#{password}\'" unless password.blank?
    command += " salty_production > backup/#{dest}.sql"
    
    sh command

    puts(Dir.pwd)
    sh("mkdir -p ~deployer/backup")
    sh("mv backup/#{dest}.sql ~deployer/backup/.")
    
  end


  task :rank => :environment do
    #ActiveRecord::Base.connection.execute("TRUNCATE ranking_temp_week_as")
    #ActiveRecord::Base.connection.execute("TRUNCATE ranking_temp_week_bs")
    #ActiveRecord::Base.connection.execute("TRUNCATE ranking_temp_week_cs")
    #ActiveRecord::Base.connection.execute("TRUNCATE ranking_temp_week_ds")

    #ActiveRecord::Base.connection.execute("TRUNCATE ranking_temp_mon_as")
    #ActiveRecord::Base.connection.execute("TRUNCATE ranking_temp_mon_bs")
    #ActiveRecord::Base.connection.execute("TRUNCATE ranking_temp_mon_cs")
    #ActiveRecord::Base.connection.execute("TRUNCATE ranking_temp_mon_ds")

    current_rank = RankingCurrent.all
    
    (0..1).each do |k|
      if k==0
        period_ = "week_"
        period = "Week"
      elsif k==1
        period_ = "mon_"
        period = "Mon"
      end
    
      (1..4).each do |j|
        category = period_ + j.to_s + " DESC"
        if j==1
          type="A"
          types="as"
        elsif j==2
          type="B"
          types="bs"
        elsif j==3
          type="C"
          types="cs"
        elsif j==4
          type="D"
          types="ds"
        end

        s = "ActiveRecord::Base.connection.execute(\"TRUNCATE ranking_temp_" + period_ + types +"\")"
        eval(s)

        current_rank.order(category).each do |i|
          option=0
          r = "option=i."+period_ + j.to_s
          eval(r)

          if option != 0
            temp=""
            q = "temp=RankingTemp" + period + type + ".new"
            eval(q)
            #temp=RankingTempWeekA.new
            temp.user_id = i.id
            p = "temp.score = i." + period_ + j.to_s
            eval(p)
            #temp.score = i.week_1
            temp.save
          end
        end
      end
    end
  end


end

