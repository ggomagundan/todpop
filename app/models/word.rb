class Word < ActiveRecord::Base


  def ko_sentence
     self.example_ko
  end

  def en_sentence
    self.example_en
  end
end
