class UsersChatroom < ActiveRecord::Base
  belongs_to :user
  belongs_to :chatroom
  belongs_to :background
end
