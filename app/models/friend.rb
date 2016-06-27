class Friend < ActiveRecord::Base
  belongs_to :user

  def self.create_friend user_id, member_id
  	create(user_id: user_id, member_id: member_id)
  	create(user_id: member_id, member_id: user_id)
  end

  def self.find_friend user, member
  	where(member_id: member, user_id: user)
  end

  def self.friend_list user #,page,size
  	members = where(user_id: user.id, is_added: true, is_block: false)
    p "====mem==#{members.pluck(:member_id).inspect}"
    ids=members.pluck(:member_id)
    User.where(id: ids)#.paginate(:page =>page, :per_page =>size)
    # p"======us====#{User.where(id: ids)}"
   end

  def self.block_list user
  	where(user_id: user.id, is_block: true)
  end

  def self.search user,username #,page,size
     members=where(user_id: user.id, is_added: true, is_block: false).pluck(:member_id)
     frinds=User.where(id: members)
     frinds.where("username ILIKE (?)","#{username}%")#.paginate(:page =>page, :per_page =>size)
  end


end
