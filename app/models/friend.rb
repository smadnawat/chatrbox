class Friend < ActiveRecord::Base
  belongs_to :user

  def self.create_friend user_id, member_id
  	create(user_id: user_id, member_id: member_id)
  	create(user_id: member_id, member_id: user_id)
  end

  def self.find_friend user, member
  	where(member_id: member, user_id: user)
  end

  def self.friend_list user
  	where(user_id: user.id, is_added: true, is_block: false)
  end

   def self.block_list user
  	where(user_id: user.id, is_block: true)
  end

end
