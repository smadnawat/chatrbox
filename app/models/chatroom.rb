class Chatroom < ActiveRecord::Base
  belongs_to :location
  has_many :users_messages_chats, dependent: :destroy
	has_many :messages, through: :users_messages_chats
	has_many :users_chatrooms, dependent: :destroy
	has_many :users, through: :users_chatrooms
end
