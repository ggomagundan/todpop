   require File.dirname(__FILE__) + '/../../config/environment.rb'
     
       namespace :word do
             task :bal => :environment do
               @success = 0
               @no_word = 0
               @err = 0
               
               Word.all.each do |w|
                 begin
                 if w.name == w.name.downcase
                  url = "http://dic.daum.net/search.do?q=#{w.name}"
                 else
                  url = "http://dic.daum.net/search.do?q=#{w.name.downcase}"
                 end
                 #url = "http://dic.naver.com/search.nhn?dicQuery=word&x=0&y=0&query=#{w.name}&target=dic&ie=utf8&query_utf=&isOnlyViewEE="
                  doc = Nokogiri::HTML(open(url)) 
                  bal = doc.xpath("//span[contains(@class, 'pronounce')]").children.text.split('[').last.split(']').first
                  #bal =  doc.xpath("//span[contains(@class, 'fnt_e25')]").first.children.text.split('[').last.split(']').first
                  if bal.size == 0 
                    File.open("words.txt", 'a') do |file|
                      file << "#{w.id}\t#{w.name}\n"
                    end
                    @no_word += 1
                    puts "no word : #{w.name}"
                  else
                    w.phonetics = bal
                    w.save
                    @success += 1
                    puts "complete : #{w.name} => #{bal}"
                  end
                 rescue Exception => e
                   File.open("err_list.txt", 'a') do |file|
                     file << "#{w.id}\t#{w.name}\n"
                   end
                   @err += 1
                   puts "err : #{w.name}"
                 end

               end
               File.open("words.txt", 'a') do |file|
                 file << "\nsum : #{@no_word}"
               end
              
               File.open("err_list.txt", 'a') do |file|
                 file << "\nsum : #{@err}"
               end
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
