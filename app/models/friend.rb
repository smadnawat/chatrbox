class Friend < ActiveRecord::Base
  belongs_to :user

  def self.create_friend user_id, member_id
  	create(user_id: user_id, mebmber_id: member_id)
  	create(user_id: member_id, mebmber_id: user_id)
  end

  def self.find_friend user, member
  	where(member_id: member, user_id: user)
  end
end
