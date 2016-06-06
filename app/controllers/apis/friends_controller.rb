class Apis::FriendsController < ApplicationController
	before_action :find_user
	before_action :find_member
	def send_message_to_friend
		friend = Friend.find_friend(@user.id, params[:single_chat_message][:member_id])
		Friend.create_friend @user.id, params[:member_id] if !friend
		chat = SingleChatMessage.new(single_chat_message_params @user)
		if chat.save
			get_response 200, "message successfully sent"
		else
			get_response 500, chat.errors.full_messages.first.capitalize.to_s.gsub('_',' ') + "."
		end
	end

	def add_block_friend
		friend = Friend.find_friend(@user.id, params[:member_id])
		if (params[:friend] == "add")
			friend.update(is_added: true)
		else
			friend.update(is_block: true)
		end
		get_response 200, "member successfully #{params[:friend]}ed"
	end

	def get_friend_messages
		SingleChatMessage.update_read_status @user.id, params[:member_id]
		messages = SingleChatMessage.get_messages @user.id, params[:member_id], params[:page], params[:size]
		render json: {code: 200, message: "successfully fetched friends messages", friends_messages: messages, pagination: Paging.set_page(params[:page], params[:size], messages ) }
	end

	def change_single_chat_background
		friend = Friend.find_friend(@user.id, params[:member_id])
		friend.update(background_id: params[:background_id])
		get_response 200, "successfully updated background"
	end

	private
	def single_chat_message_params user
		params[:single_chat_message][:user_id] = user.id
		params.require(:single_chat_message).permit(:member_id, :message, :media)
	end
end
