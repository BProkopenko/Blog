class AddCollumnsToPosts < ActiveRecord::Migration[5.0]
  def change
    add_reference :posts, :topic, foreign_key: true
    add_column :posts, :title, :string
    add_column :posts, :new, :boolean, default: true
    add_column :posts, :accepted, :boolean, default: false
    add_column :posts, :pending, :boolean, default: false
  end
end
