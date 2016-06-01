class Apis::ChatroomsController < ApplicationController
	before_action :find_user
	before_action :find_chatroom, only: [:leave_group, :create_chatroom_message, :my_chatroom_messages, :chatroom_details]
	
	# list of all chatroom from backend
	def get_chatroom
		chatroom = Chatroom.all_chatrooms(@user, params[:page], params[:size])
		render json: {code: 200, message: "successfully fetched chatrooms", locations: chatroom.first , pagination: chatroom.last }
	end

	# add chaatroom to list
	def add_chatroom
		return get_response 500, "please select chatrooms to add in your list" if !params[:chatroom_id].present?
		common = params[:chatroom_id]&@user.chatrooms.pluck(:id)
		UsersChatroom.delete_users_chatrooms @user, common if common.present?
		@user.chatrooms << Chatroom.find_chatroom(params[:chatroom_id]-common)
		get_response 200, "successfully added."
	end

	# my chatroom list
	def my_chatroom
		chatroom = @user.chatrooms.order('name asc').paginate(:page => params[:page], :per_page => params[:size])
		render json: {code: 200, message: "successfully fetched my chatrooms", chatrooms: chatroom, pagination: Paging.set_page(params[:page], params[:size], chatroom ) }
	end

	# create chatroom messages
	def create_chatroom_message
		message = @user.messages.build(message_params)
		if message.save
			@chatroom.users.map{ |x| (UsersMessagesChat.after_create_message x, @chatroom, message) }
			get_response 200, "successfully created"
		else
			get_response 500, message.errors.full_messages.first.capitalize.to_s.gsub('_',' ') + "."
		end
	end

	# get my chatroom messages
	def my_chatroom_messages
		chatroom_messages = @chatroom.messages.order('created_at desc').paginate(:page => params[:page], :per_page => params[:size])
		UsersMessagesChat.uodate_unread_status @user, @chatroom
		render json: {code: 200, message: "successfully fetched my chatrooms", chatroom_messages: chatroom_messages, pagination: Paging.set_page(params[:page], params[:size], chatroom_messages ) }
	end

	# chatrom details 
	def chatroom_details
		chatroom_users = @chatroom.users.order('username asc').paginate(:page => params[:page], :per_page => params[:size])
		user_chat = UsersChatroom.get_user_chatroom @user, @chatroom
		render json: {code: 200, message: "successfully fetched my chatrooms", 
		chatroom_details: @chatroom.as_json(only: [:id, :name, :image]).merge(users: chatroom_users.as_json(only: [:id, :username, :image]), is_mute: user_chat.is_notified ), 
		pagination: Paging.set_page(params[:page], params[:size], chatroom_users ) }
	end

	# leave this group
	def leave_group
		user_chat = UsersChatroom.get_user_chatroom @user, @chatroom
		return get_response 200, "already left group"  if !user_chat
		user_chat.delete
		get_response 200, "successfully left group"
	end

	# private methods
	private
	def message_params
		params.require(:message).permit(:content, :media)
	end

end
