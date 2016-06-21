class SingleChatMessage < ActiveRecord::Base
  belongs_to :user
  mount_uploader :media, AvatarUploader

  def self.update_read_status user, member
  	where(member_id: user, user_id: member, is_read: false).update_all(is_read: true)
  end

  def self.get_messages user, member, page, size
  	where(member_id: member, user_id: user).order('created_at desc').paginate(:page =>page, :per_page =>size)
  end

end
