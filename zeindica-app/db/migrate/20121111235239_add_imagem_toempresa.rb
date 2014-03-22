class AddImagemToempresa < ActiveRecord::Migration
  def up
		add_column :empresas, :imagem_topo_file_name, :string
		add_column :empresas, :imagem_meio_file_name, :string
		add_column :empresas, :imagem_inferior_file_name, :string
  end

  def down
		remove_column :empresas, :imagem_topo_file_name
		remove_column :empresas, :imagem_meio_file_name
		remove_column :empresas, :imagem_inferior_file_name
  end
end
