class UsersChatroom < ActiveRecord::Base
  belongs_to :user
  belongs_to :chatroom
  belongs_to :background

  def self.delete_users_chatrooms user, common
  	where('user_id = ? and chatroom_id NOT IN (?)', user.id, common).destroy_all
  end

  def self.get_user_chatroom user, chat
  	where(user_id: user.id, chatroom_id: chat.id).last
  end

end
