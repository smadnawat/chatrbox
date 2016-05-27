require 'will_paginate/array'
class Location < ActiveRecord::Base
	validates_presence_of :name, :flag_image
	mount_uploader :flag_image, AvatarUploader

	def self.all_locations user, page, size
		all.order('name asc').paginate(:page => page, :per_page => size).map{|x| x.slice('id', 'name', 'flag_image') }
	end
end
