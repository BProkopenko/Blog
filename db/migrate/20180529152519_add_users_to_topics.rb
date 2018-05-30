class AddUsersToTopics < ActiveRecord::Migration[5.0]
  def change
    add_reference :topics, :user, foreign_key: true
    add_index :topics, [:user_id, :created_at]
  end
end
