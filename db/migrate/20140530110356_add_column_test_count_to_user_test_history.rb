class AddColumnTestCountToUserTestHistory < ActiveRecord::Migration
  def change
    add_column :user_test_histories, :test_count, :integer, :after => :rank_point
  end
end
