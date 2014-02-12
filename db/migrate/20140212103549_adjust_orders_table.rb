class AdjustOrdersTable < ActiveRecord::Migration
  def change
    add_column :orders, :coupon_company, :string
    add_column :orders, :issue_date, :string

    rename_column :orders, :qpcon_order_id, :apporoval_number
  end
end
