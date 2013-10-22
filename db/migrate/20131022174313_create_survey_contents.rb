class CreateSurveyContents < ActiveRecord::Migration
  def change
    create_table :survey_contents do |t|
      t.integer :ad_id
      t.integer :q_no
      t.integer :q_type
      t.string :q_text
      t.string :q_image
      t.integer :n_answer
      t.string :a1
      t.string :a2
      t.string :a3
      t.string :a4
      t.string :a5

      t.timestamps
    end
  end
end
