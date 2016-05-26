class Location < ActiveRecord::Base
	validates_presence_of :name, :flag_image
	mount_uploader :flag_image, AvatarUploader
end
