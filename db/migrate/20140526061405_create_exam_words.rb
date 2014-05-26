class CreateExamWords < ActiveRecord::Migration
  def change
    create_table :exam_words do |t|
      t.integer :exam_no
      t.string :title
      t.integer :part
      t.string :word
      t.string :mean

      t.timestamps
    end
  end
end
