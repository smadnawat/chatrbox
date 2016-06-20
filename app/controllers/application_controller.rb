class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
	require 'will_paginate/array'
	
  def get_response code, message
		render json: {code: code, message: message}
  end
	def find_user
		@user = User.where(id: params[:id], authentication_token: request.headers["HTTP_TOKEN"], is_active: true).last
		return get_response 500, "you are not authorise user to perform this action" if !@user.present?
	end
	def find_chatroom
		 @chatroom = Chatroom.find_by_id(params[:chatroom_id])#.first
		return get_response 500, "chatroom not found" if !@chatroom.present?
	end
	def find_member
		@member = User.find_by_id(params[:member_id])
		
		return get_response 500, "member not found" if !@member.present?
	end

end
