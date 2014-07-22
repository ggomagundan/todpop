class CreateBoardNoticePros < ActiveRecord::Migration
  def change
    create_table :board_notice_pros do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
