class ChangeColumnOrder < ActiveRecord::Migration
  def change
  	change_column :cpd_advertisements, :ad_name, :string, :after => :id
  	change_column :cpdm_advertisements, :ad_name, :string, :after => :id
  	change_column :cpdm_advertisements, :count, :integer, :after => :ad_type
  	change_column :cpdm_advertisements, :remain, :integer, :after => :count
  	change_column :cpdm_advertisements, :url, :string, :after => :end_date
  	change_column :cpdm_advertisements, :length, :string, :after => :url
  	change_column :cpx_advertisements, :ad_name, :string, :after => :id
  	change_column :cpx_advertisements, :count, :integer, :after => :ad_type
  	change_column :cpx_advertisements, :remain, :integer, :after => :count
  	change_column :cpx_advertisements, :ad_image, :string, :after => :end_date
  	change_column :cpx_advertisements, :ad_text, :string, :after => :ad_image
  	change_column :cpx_advertisements, :store_url, :string, :after => :ad_text
  	change_column :cpx_advertisements, :package_name, :string, :after => :store_url
  	change_column :cpx_advertisements, :confirm_url, :string, :after => :package_name
  	change_column :cpx_advertisements, :reward, :integer, :after => :confirm_url
  	change_column :cpx_advertisements, :n_question, :integer, :after => :reward
  	change_column :cpx_advertisements, :priority, :integer, :after => :updated_at
  end
end
