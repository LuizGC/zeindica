class DeviseCreateUsuarios < ActiveRecord::Migration
  def change
    create_table(:usuarios) do |t|
      ## Database authenticatable
      t.string :email, :null => false, :default => ""

      ## Trackable
      t.integer :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string :current_sign_in_ip
      t.string :last_sign_in_ip

      t.string :nome
      t.string :facebook_link

      t.timestamps
    end

    add_index :usuarios, :email, :unique => true
		add_index :usuarios, :facebook_link, :unique => true
  end
end
