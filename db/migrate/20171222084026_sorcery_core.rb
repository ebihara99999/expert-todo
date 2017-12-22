class SorceryCore < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :encrypted_password, :crypted_password
    add_column :users, :salt, :string
  end
end
