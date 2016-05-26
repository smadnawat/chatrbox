class Background < ActiveRecord::Base
	validates_presence_of :name, :image
	mount_uploader :image, AvatarUploader
end
