class Chatroom < ActiveRecord::Base
	belongs_to :location
	has_many :users_messages_chats, dependent: :destroy
	has_many :messages, through: :users_messages_chats
	has_many :users_chatrooms, dependent: :destroy
	has_many :users, through: :users_chatrooms
	mount_uploader :image, AvatarUploader
	validates_presence_of :name
	validates_presence_of :image , message: "Please select file"
	validates_presence_of :location_id, message: "Please select location"

	def self.all_chatrooms user, page, size
		all.order('name asc').paginate(:page => page, :per_page => size).map{|x| x.slice('id', 'name', 'image') }
	end
end
