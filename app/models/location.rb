require 'will_paginate/array'
class Location < ActiveRecord::Base
	validates_presence_of :name
	validates_presence_of :flag_image , message: "Please select file"
	mount_uploader :flag_image, AvatarUploader

	def self.all_locations user, page, size
		all.order('name asc').paginate(:page => page, :per_page => size).map{|x| x.slice('id', 'name', 'flag_image') }
	end
end
