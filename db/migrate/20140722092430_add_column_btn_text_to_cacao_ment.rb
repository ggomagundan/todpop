class AddColumnBtnTextToCacaoMent < ActiveRecord::Migration
  def change
    add_column :cacao_ments, :btn_text, :string, :after => :ment
  end
end
