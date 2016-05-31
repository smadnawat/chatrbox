class Apis::ChatroomsController < ApplicationController
	before_action :find_user
	
	# list of all chatroom from backend
	def get_chatroom
		chatroom = Chatroom.all_chatrooms(@user, params[:page], params[:size])
		render json: {code: 200, message: "successfully fetched chatrooms", locations: chatroom.first , pagination: chatroom.last }
	end

	# add chaatroom to list
	def add_chatroom
		chatroom = Chatroom.find_chatroom params[:id]
		@user.chatrooms << chatroom
		get_response 200, "successfully added."
	end

end
