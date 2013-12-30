class AddColumnCpxPoint < ActiveRecord::Migration
  def change
    add_column :cpx_advertisements, :point, :integer, :after => :reward
  end
end
