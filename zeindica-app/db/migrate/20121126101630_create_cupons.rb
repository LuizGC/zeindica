class CreateCupons < ActiveRecord::Migration
  def change
    create_table :cupons do |t|
      t.references :usuario, :null => false
      t.references :premio, :null => false
      t.boolean :premiado, :null => false, :default => false
      t.boolean :depositado, :null => false, :default => false

      t.timestamps
    end
    add_index :cupons, :usuario_id
    add_index :cupons, :premio_id
  end
end
