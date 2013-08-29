class Word < ActiveRecord::Base

  has_many :level
  mount_uploader :image, ImageUploader

  def ko_sentence
     self.example_ko
  end

  def en_sentence
    self.example_en
  end
end
