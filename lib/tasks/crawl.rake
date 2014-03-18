   require File.dirname(__FILE__) + '/../../config/environment.rb'
     
       namespace :word do
             task :bal => :environment do
               @cnt = 0
               @list = ""
               @success = 0
               Word.all.each do |w|
                 begin
                 if w.name != w.name.downcase
                 url = "http://dic.daum.net/search.do?q=#{w.name}"
                 else
                 url = "http://dic.daum.net/search.do?q=#{w.name.downcase}"
                 end
                 #url = "http://dic.naver.com/search.nhn?dicQuery=word&x=0&y=0&query=#{w.name}&target=dic&ie=utf8&query_utf=&isOnlyViewEE="
                  doc = Nokogiri::HTML(open(url)) 
                  bal = doc.xpath("//span[contains(@class, 'pronounce')]").children.text.split('[').last.split(']').first
                  #bal =  doc.xpath("//span[contains(@class, 'fnt_e25')]").first.children.text.split('[').last.split(']').first
                  w.phonetics = bal
                  w.save
                  @success += 1
                 rescue Exception => e
                   @cnt += 1
                   @list += "#{w.name}\t"
                 end

               end
               puts @list
               puts @cnt
               puts @success

          end


             task :exam => :environment do
               Word.all.each do |w|
                 url = "http://endic.naver.com/search_example.nhn?query=#{w.name}&isOnlyViewEE=Y"
                  doc1 = Nokogiri::HTML(open(url)) 
                 en =doc1.xpath("//li[contains(@class, 'utb')]").first.xpath("span[contains(@class,'fnt_e09')]").first.text
                 ko = doc1.xpath("//li[contains(@class, 'utb')]").first.xpath("//div[contains(@class,'mar_top1')]").first.text
                  w.example_en = en
                  w.example_ko = ko
                  w.save

               end

          end

      end
