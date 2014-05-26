class CreateExamWordsLogs < ActiveRecord::Migration
  def change
    create_table :exam_words_logs do |t|
      t.integer :exam_no
      t.integer :part
      t.integer :user_id
      t.integer :score

      t.timestamps
    end
  end
end
