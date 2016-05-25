class UsersMessagesChat < ActiveRecord::Base
  belongs_to :message
  belongs_to :user
  belongs_to :chatroom
end
