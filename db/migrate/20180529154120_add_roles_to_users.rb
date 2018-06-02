class AddRolesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :moder, :boolean, default: false, :null => false
  end
end
