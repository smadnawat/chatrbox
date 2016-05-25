class Message < ActiveRecord::Base
  belongs_to :user
  has_many :users_messages_chats, dependent: :destroy
	has_many :chatrooms, through: :users_messages_chats
end
