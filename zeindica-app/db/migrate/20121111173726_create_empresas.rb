class CreateEmpresas < ActiveRecord::Migration
  def change
    create_table :empresas do |t|
      t.string :nome, :null => false
      t.string :telefone, :null => false

      t.timestamps
    end
  end
end
