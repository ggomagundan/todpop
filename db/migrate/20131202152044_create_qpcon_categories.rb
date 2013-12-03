class CreateQpconCategories < ActiveRecord::Migration
  def change
    create_table :qpcon_categories do |t|
      t.string :category_id
      t.string :category_name

      t.timestamps
    end
  end
end
