class AddLinksToEmpresas < ActiveRecord::Migration
  def change
  	add_column :empresas, :link_to_imagem_topo, :string
		add_column :empresas, :link_to_imagem_meio, :string
		add_column :empresas, :link_to_imagem_inferior, :string
	end
end
