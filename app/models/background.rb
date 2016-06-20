class Background < ActiveRecord::Base
	# validates_presence_of :name
	validates_presence_of :image , message: "Please select file"
	mount_uploader :image, AvatarUploader
	has_many :users_chatrooms
	# before_destroy {user_chatrooms.clear}
	before_destroy :clear_chatrooms_background

	validates :name, length: { minimum: 2,
                                 too_short: "Minimum length should be %{count} " }
 	validates :name, length: { maximum: 28,
                                 too_long: "Name must not exceed %{count} characters" }
    # validates_format_of :name, :with => /[^a-eg-z]/
    # validates   :name , format:{ with: /\A[a-zA-Z0-9]+\Z/,
    #                         message: 'Please Enter Characters only!!' } 
	def self.all_backgrounds user, page, size
		backgrounds = all.order('name asc').paginate(:page => page, :per_page => size)
		[backgrounds.map{|x| x.slice('id', 'name', 'image')}, Paging.set_page(page, size, backgrounds)]
	end

	def clear_chatrooms_background
		self.users_chatrooms.update_all(background_id: nil)
	end
end
