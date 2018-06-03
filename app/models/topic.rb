class Topic < ApplicationRecord
	belongs_to :user
	has_many :posts, dependent: :destroy
	default_scope -> {order(created_at: :desc)}
	validates :theme, presence: true
end
