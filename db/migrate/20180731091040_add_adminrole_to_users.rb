class AddAdminroleToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :aminrole, :boolean, :default => false
  end
end
