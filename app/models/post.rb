class Post < ApplicationRecord
	belongs_to :user
	belongs_to :topic
	has_many :comments, dependent: :destroy
	default_scope -> {order(created_at: :desc)}
	mount_uploader :picture, AvatarUploader
	validates :user_id, presence: true
	validates :title, presence: true
	validates :topic_id, presence: true
	validates :content, presence: true, length: {maximum: 140}
	validate :picture_size

	private

	def picture_size
		if picture.size > 5.megabytes
			errors.add(:picture, "should be less than 5MB")
		end
	end
end
