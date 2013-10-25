class AddDeleteArangeColumnsToProduct < ActiveRecord::Migration
  def change
    add_column :products, :date_start, :datetime 
    add_column :products, :date_end,   :datetime 
    add_column :products, :content1,   :text 
    add_column :products, :content2,   :text 
    add_column :products, :content3,   :text 
    remove_column :products, :title,   :string 
    remove_column :products, :content, :string 
    change_column :products, :category,   :integer, :after => :name
    change_column :products, :period,     :integer, :after => :category
    change_column :products, :date_start, :datetime, :after => :rank
    change_column :products, :date_end,   :datetime, :after => :date_start
    change_column :products, :content1,   :text, :after => :image
    change_column :products, :content2,   :text, :after => :content1
    change_column :products, :content3,   :text, :after => :content2
  end
end
