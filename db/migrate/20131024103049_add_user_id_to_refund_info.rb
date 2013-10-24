class AddUserIdToRefundInfo < ActiveRecord::Migration
  def change
    add_column :refund_infos, :user_id, :integer
  end
end
