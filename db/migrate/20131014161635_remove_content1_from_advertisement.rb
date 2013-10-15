class RemoveContent1FromAdvertisement < ActiveRecord::Migration
  def change
    remove_column :advertisements, :content1, :string
    remove_column :advertisements, :content2, :string
  end
end
