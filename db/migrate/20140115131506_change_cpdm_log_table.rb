class ChangeCpdmLogTable < ActiveRecord::Migration
  def change
    add_column :advertise_cpdm_logs, :act, :integer, :after => :user_id
    add_column :advertise_cpdm_logs, :facebook_id, :string, :after => :view_time
  
    add_column :cpd_advertisements, :action_price, :integer, :after => :unit_price
    add_column :cpd_advertisements, :reward, :integer
    add_column :cpd_advertisements, :point, :integer
    add_column :cpd_advertisements, :name, :string
    add_column :cpd_advertisements, :caption, :string
    add_column :cpd_advertisements, :description, :string
    add_column :cpd_advertisements, :link, :string
    add_column :cpd_advertisements, :picture, :string

    add_column :advertise_cpd_logs, :facebook_id, :string, :after => :act
  end
end
