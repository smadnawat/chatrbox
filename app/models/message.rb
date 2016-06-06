class Message < ActiveRecord::Base
  # serialize :is_read, Array
  belongs_to :user
  belongs_to :chatroom
  mount_uploader :media, AvatarUploader
  # has_many :users_messages_chats, dependent: :destroy
	# has_many :chatrooms, through: :users_messages_chats
	validates_presence_of :content, :chatroom_id


	# def self.get_unread_chatroom_messages user, chatroom
	# 	where(user_id: user.id, chatroom_id: chatroom.id)
	# end

	def self.update_unread_message_status user, chatroom
		my_read_msg = where("'?' = ANY (is_read) and chatroom_id = ?", user.id, chatroom.id).pluck(:id)
		where('chatroom_id = ? and id NOT IN (?)', chatroom.id, my_read_msg).update_all(['is_read = is_read || ?::text', user.id])
	end

end
