class CreateBoardHelpPros < ActiveRecord::Migration
  def change
    create_table :board_help_pros do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
