class AddCollumnsToPosts < ActiveRecord::Migration[5.0]
  def change
    add_reference :posts, :topic, foreign_key: true
    add_column :posts, :title, :string
    add_column :posts, :new_post, :boolean, default: true, :null => false
    add_column :posts, :accepted, :boolean, default: false, :null => false
    add_column :posts, :pending, :boolean, default: false, :null => false
    add_column :posts, :rejected, :boolean, default: false,:null => false
  end
end
