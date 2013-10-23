require File.dirname(__FILE__) + '/../../config/environment.rb'
   
  namespace :ads do
    task :cpd_priorities => :environment do
      CpdAdvertisement.all.each do |cpd|
        term_date = cpd.end_time.to_date - Date.today
        if cpd.remain <= 0
            cpd.update_attributes(:priority => 99)
        elsif cpd.priority == 1
        elsif cpd.priority == 5
        elsif term_date <= 0
            cpd.update_attributes(:priority => 2)
        elsif cpd.end_time.to_date - cpd.start_time.to_date >= 270
          if term_date <=  90
            cpd.update_attributes(:priority => 2)
          elsif term_date <= 180
            cpd.update_attributes(:priority => 3)
          else
            cpd.update_attributes(:priority => 4)
          end
        elsif cpd.end_time.to_date - cpd.start_time.to_date >= 180
          if term_date <=  60
            cpd.update_attributes(:priority => 2)
          elsif term_date <= 120
            cpd.update_attributes(:priority => 3)
          else
            cpd.update_attributes(:priority => 4)
          end
        else
          if term_date <=  30
            cpd.update_attributes(:priority => 2)
          elsif term_date <= 60
            cpd.update_attributes(:priority => 3)
          else
            cpd.update_attributes(:priority => 4)
          end

        end
      end 
    end

    task :cpdm_priorities => :environment do
      CpdmAdvertisement.all.each do |cpdm|
        term_date = ad.end_time - Date.today
        if cpdm.remain <= 0
            cpdm.update_attributes(:priority => 99)
        elsif cpdm.priority == 1
        elsif cpdm.priority == 5
        elsif term_date <= 0
            cpdm.update_attributes(:priority => 2)
        elsif cpdm.end_time.to_date - cpdm.start_time.to_date >= 270
          if term_date <=  90
            cpdm.update_attributes(:priority => 2)
          elsif term_date <= 180
            cpdm.update_attributes(:priority => 3)
          else
            cpdm.update_attributes(:priority => 4)
          end
        elsif cpdm.end_time.to_date - cpdm.start_time.to_date >= 180
          if term_date <=  60
            cpdm.update_attributes(:priority => 2)
          elsif term_date <= 120
            cpdm.update_attributes(:priority => 3)
          else
            cpdm.update_attributes(:priority => 4)
          end
        else
          if term_date <=  30
            cpdm.update_attributes(:priority => 2)
          elsif term_date <= 60
            cpdm.update_attributes(:priority => 3)
          else
            cpdm.update_attributes(:priority => 4)
          end

        end
      end 
    end

    task :cpx_priorities => :environment do

      ads = CpxAdvertisement.where('priority >= 2')
      
      ads.each do |cpx|
        if cpx.remain <= 0
          cpx.update_attributes(:priority => 99)
        elsif cpx.end_time.to_date - Date.today.to_date <= 10 
          cpx.update_attributes(:priority => 2)
        elsif Date.today.to_date - cpx.start_time.to_date <= 10
          cpx.update_attributes(:priority => 3)
        elsif Date.today.to_date - cpx.start_time.to_date <= 30
          cpx.update_attributes(:priority => 4)
        else
          cpx.update_attributes(:priority => 5)
        end
      end
    end

  end

