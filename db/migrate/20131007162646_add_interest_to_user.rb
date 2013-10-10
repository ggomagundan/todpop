# -*- encoding : utf-8 -*-
class AddInterestToUser < ActiveRecord::Migration
  def change
    add_column :users, :interest, :integer
  end
end
