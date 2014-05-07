class AddColumnTitleMentlist < ActiveRecord::Migration
  def change
    add_column :ment_lists, :title, :string, :after => :kind
  end
end
