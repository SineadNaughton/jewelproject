class AddAdminrole2ToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :adminrole, :boolean, :default => false
  end
end
