class UsersChatroom < ActiveRecord::Base
  belongs_to :user
  belongs_to :chatroom
  belongs_to :background

  def self.delete_users_chatrooms user, common
  	where('user_id = ? and id NOT IN (?)', user.id, common).destroy_all
  end

end
