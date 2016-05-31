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
		chatrooms = all.order('name asc').paginate(:page => page, :per_page => size)
		[chatrooms.map{ |x| x.slice('id', 'name', 'image') }, Paging.set_page(page, size, chatrooms)]
	end

	def self.find_chatroom id
		where(id: id).last
	end
end
