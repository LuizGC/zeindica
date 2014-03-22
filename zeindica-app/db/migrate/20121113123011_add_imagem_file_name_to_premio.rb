class AddImagemFileNameToPremio < ActiveRecord::Migration
	def self.up
		add_column :premios, :imagem_nuvem_file_name, :string
		add_column :premios, :imagem_info_file_name, :string
	end
 
	def self.down
		remove_column :premios, :imagem_nuvem_file_name, :string
		remove_column :premios, :imagem_info_file_name, :string
  end
end
