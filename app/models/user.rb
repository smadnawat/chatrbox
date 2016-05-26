class User < ActiveRecord::Base
	has_one :subscription, dependent: :destroy
	has_one :location, dependent: :destroy
	has_many :contact_us, dependent: :destroy
	has_many :friends, dependent: :destroy
	has_many :users_chatrooms, dependent: :destroy
	has_many :chatrooms, through: :users_chatrooms
	has_many :users_messages_chats, dependent: :destroy
	has_many :messages, through: :users_messages_chats
	mount_uploader :image, AvatarUploader
end
