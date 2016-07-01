class SingleChatMessage < ActiveRecord::Base
  belongs_to :user
  mount_uploader :media, AvatarUploader

  def self.update_read_status user, member
  	where(member_id: user, user_id: member, is_read: false).update_all(is_read: true)
  end

  def self.get_messages user, member, page, size

    p "===page00==#{page}====s========="
  	where("(user_id = ? and member_id = ?) or (user_id = ? and member_id = ?) ", user,member,member,user).order('created_at desc').paginate(:page =>page.to_i, :per_page =>size.to_i)
  	#where(member_id: member, user_id: user).order('created_at desc').paginate(:page =>page, :per_page =>size)
  end

  def self.is_exist user,member
  	where("(user_id = ? and member_id = ?) or (user_id = ? and member_id = ?) ", user,member,member,user).present?
  end

  def self.media_data(data)
    return nil unless data
    io = CarrierStringIO.new(Base64.decode64(data)) 
  end

  def self.get_last_message user, member
    last_message = get_messages(user, member, 1, 10).first
    # where("(user_id = ? and member_id = ?) or (user_id = ? and member_id = ?) ", user_id,member_id,member_id,user_id).present? ? where("(user_id = ? and member_id = ?) or (user_id = ? and member_id = ?) ", user_id,member_id,member_id,user_id).last : '_'
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
