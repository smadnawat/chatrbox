class Location < ActiveRecord::Base
	# has_one :users_location
	# has_one :user, through: :users_location
	has_and_belongs_to_many :users, join_table: "users_locations"
	before_destroy {users.clear}
	has_many :chatrooms, dependent: :destroy
	# has_and_belongs_to_many :chatrooms, join_table: "chatrooms_lcations"
	# before_destroy {chatrooms.clear}
	validates_presence_of :name
	validates_presence_of :flag_image , message: "Please select file"
	mount_uploader :flag_image, AvatarUploader

	def self.all_locations user, page, size
		locations = all.order('name asc').paginate(:page => page, :per_page => size)
		[locations.map{|x| x.slice('id', 'name', 'flag_image').merge(is_selected: user.locations.include?(x)) }, Paging.set_page(page, size, locations)]
	end
	
end
