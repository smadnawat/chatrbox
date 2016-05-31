class Apis::ChatroomsController < ApplicationController
	before_action :find_user
	
	# list of all chatroom from backend
	def get_chatroom
		chatroom = Chatroom.all_chatrooms(@user, params[:page], params[:size])
		render json: {code: 200, message: "successfully fetched chatrooms", locations: chatroom.first , pagination: chatroom.last }
	end

	# add chaatroom to list
	def add_chatroom
		p"=========#{params.inspect}================="
		common = params[:chatroom_id]&@user.chatrooms.pluck(:id)
		p "====#{common}==common="
		# chatroom = Chatroom.find_chatroom params[:chatroom_id]
		# common_chat = chatroom&@user.chatrooms
		# remain = chatroom - common_chat
		# @user.chatrooms.where('id NOT IN (?)', common).destroy_all
		UsersChatroom.delete_users_chatrooms @user, common if common.present?
		# Chatroom.delete_users_chatrooms @user, common
		p "=====#{params[:chatroom_id]-common}====="
		@user.chatrooms << Chatroom.find_chatroom(params[:chatroom_id]-common)
		get_response 200, "successfully added."
	end

end
