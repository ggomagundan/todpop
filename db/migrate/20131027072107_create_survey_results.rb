class CreateSurveyResults < ActiveRecord::Migration
  def change
    create_table :survey_results do |t|
      t.integer :ad_id
      t.integer :user_id
      t.string :answers

      t.timestamps
    end
  end
end
