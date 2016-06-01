class UsersMessagesChat < ActiveRecord::Base
  belongs_to :message
  belongs_to :user
  belongs_to :chatroom

  def self.after_create_message user, chatroom, message
  	create(user_id: user.id, chatroom_id: chatroom.id, message_id: message.id)
  end

  def self.uodate_unread_status user, chat
  	where(user_id: user.id, chatroom_id: chat.id).update_all(is_read: true)
  end
end
