require File.dirname(__FILE__) + '/../../config/environment.rb'
   
  namespace :ads do
    task :cpd_priorities => :environment do
      CpdAdvertisement.all.each do |cpd|
        term_date = cpd.end_time.to_date - Date.today
        if cpd.priority == 1
        elsif cpd.end_time.to_date - cpd.start_time.to_date >= 270 || term_date <= 0
          if term_date <=  90
            cpd.update_attributes(:priority => 2)
          elsif term_date <= 180
            cpd.update_attributes(:priority => 3)
          end
        elsif cpd.end_time.to_date - cpd.start_time.to_date >= 180
          if term_date <=  60
            cpd.update_attributes(:priority => 2)
          elsif term_date <= 120
            cpd.update_attributes(:priority => 3)
          end
        else
          if term_date <=  60
            cpd.update_attributes(:priority => 2)
          elsif term_date <= 120
            cpd.update_attributes(:priority => 3)
          end

        end
      end 
    end

    task :cpdm_priorities => :environment do
      CpdmAdvertisement.all.each do |ad|
        term_date = ad.end_time - Date.today
        if ad.priority == 1
        elsif ad.end_time - ad.start_time >= 270 || term_date <= 0
          if term_date <=  90
            ad.update_attributes(:priority => 2)
          elsif term_date <= 180
            ad.update_attributes(:priority => 3)
          end
        elsif ad.end_time.to_date - ad.start_time.to_date >= 180
          if term_date <=  60
            ad.update_attributes(:priority => 2)
          elsif term_date <= 120
            ad.update_attributes(:priority => 3)
          end
        else
          if term_date <=  60
            ad.update_attributes(:priority => 2)
          elsif term_date <= 120
            ad.update_attributes(:priority => 3)
          end

        end
      end 
    end

    task :cpx_priorities => :environment do

      ads = CpxAdvertisement.where('priority >= 2')
      
      ads.each do |ad|
        if ad.end_time - Date.today <= 10 
          ad.update_attributes(:priority => 2)
        elsif Date.today - ad.start_time <= 10
          ad.update_attributes(:priority => 3)
        elsif Date.today - ad.start_time <= 30
          ad.update_attributes(:priority => 4)
        else
          ad.update_attributes(:priority => 5)
        end
      end
    end

  end

