class AddAdminToUsuarios < ActiveRecord::Migration
  def change
		add_column :usuarios, :admin, :boolean,:default => 0, :null => false
  end
end
