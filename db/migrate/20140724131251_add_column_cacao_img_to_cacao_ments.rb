class AddColumnCacaoImgToCacaoMents < ActiveRecord::Migration
  def change
    add_column :cacao_ments, :img_url, :string, :after => :btn_text
    add_column :cacao_ments, :img_width, :string, :after => :img_url
    add_column :cacao_ments, :img_height, :string, :after => :img_width
  end
end
