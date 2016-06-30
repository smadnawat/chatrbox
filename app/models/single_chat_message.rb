class SingleChatMessage < ActiveRecord::Base
  belongs_to :user
  mount_uploader :media, AvatarUploader

  def self.update_read_status user, member
  	where(member_id: user, user_id: member, is_read: false).update_all(is_read: true)
  end

  def self.get_messages user, member, page, size
  	where("(user_id = ? and member_id = ?) or (user_id = ? and member_id = ?) ", user,member,member,user).order('created_at desc').paginate(:page =>page, :per_page =>size)
  	#where(member_id: member, user_id: user).order('created_at desc').paginate(:page =>page, :per_page =>size)
  end

  def self.is_exist user,member
  	where("(user_id = ? and member_id = ?) or (user_id = ? and member_id = ?) ", user,member,member,user).present?
  end

  def self.media_data(data)
    return nil unless data
    io = CarrierStringIO.new(Base64.decode64(data)) 
  end

end

class CarrierStringIO < StringIO
  def original_filename
    "photo.jpeg"
  end

  def content_type
    "image/jpeg"
  end

end
