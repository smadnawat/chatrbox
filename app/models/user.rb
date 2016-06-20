class User < ActiveRecord::Base

	has_one :subscription, dependent: :destroy
	# has_one :users_location
	# has_one :location, through: :users_location
	has_and_belongs_to_many :locations, join_table: "users_locations"
	before_destroy {locations.clear}
	has_many :reports , dependent: :destroy
	has_many :contact_us, dependent: :destroy
	has_many :gadgets, dependent: :destroy
	has_many :friends, dependent: :destroy
	has_many :users_chatrooms, dependent: :destroy
	has_many :chatrooms, through: :users_chatrooms
	# has_many :users_messages_chats, dependent: :destroy
	has_many :messages, dependent: :destroy
	has_many :single_chat_messages, dependent: :destroy
	# has_many :messages, through: :users_messages_chats
	mount_uploader :image, AvatarUploader


	validates_presence_of :fb_id
	validates_uniqueness_of :username

	def self.find_by_fb_id id
		find_by(fb_id: id)
	end

	def self.image_data(data)
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
