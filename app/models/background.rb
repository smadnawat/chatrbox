class Background < ActiveRecord::Base
	validates_presence_of :name
	validates_presence_of :image , message: "Please select file"
	mount_uploader :image, AvatarUploader

	def self.all_backgrounds user, page, size
		backgrounds = all.order('name asc').paginate(:page => page, :per_page => size)
		[backgrounds.map{|x| x.slice('id', 'name', 'image')}, Paging.set_page(page, size, backgrounds)]
	end
end
