class Chatroom < ActiveRecord::Base
	validates_presence_of :name, :image, :location_id
	belongs_to :location
	has_many :users_messages_chats, dependent: :destroy
	has_many :messages, through: :users_messages_chats
	has_many :users_chatrooms, dependent: :destroy
	has_many :users, through: :users_chatrooms
	mount_uploader :image, AvatarUploader
end
