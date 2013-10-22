class ChangeColumnCpxAdvertisements < ActiveRecord::Migration
  def change
  	rename_column :cpx_advertisements, :kind, :ad_type
  	rename_column :cpx_advertisements, :start_time, :start_date
  	rename_column :cpx_advertisements, :end_time, :end_date
  	rename_column :cpx_advertisements, :name, :ad_name
  	add_column :cpx_advertisements, :ad_text, :string
  	add_column :cpx_advertisements, :store_url, :string
  	add_column :cpx_advertisements, :confirm_url, :string
  	add_column :cpx_advertisements, :package_name, :string
  	add_column :cpx_advertisements, :ad_image, :string
  	add_column :cpx_advertisements, :reward, :integer
  	add_column :cpx_advertisements, :n_question, :integer
  	remove_column :cpx_advertisements, :url

  end
end
