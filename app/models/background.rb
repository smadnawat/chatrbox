class Background < ActiveRecord::Base
	validates_presence_of :name
	validates_presence_of :image , message: "Please select file"
	mount_uploader :image, AvatarUploader
end
