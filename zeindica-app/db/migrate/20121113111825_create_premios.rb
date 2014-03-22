class CreatePremios < ActiveRecord::Migration
  def change
    create_table :premios do |t|
      t.string :nome, :null => false
      t.text :descricao, :null => false
      t.date :sorteio, :null => false
      t.integer :empresa_id, :null => false

      t.timestamps
    end
  end
end
