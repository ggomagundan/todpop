class CreateCacaoMents < ActiveRecord::Migration
  def change
    create_table :cacao_ments do |t|
      t.string :ment

      t.timestamps
    end
  end
end
