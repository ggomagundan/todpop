class AddColumnQNoToExamWords < ActiveRecord::Migration
  def change
    add_column :exam_words, :q_no, :string, :after => :mean
  end
end
