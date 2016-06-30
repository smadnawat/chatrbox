class Apis::ChatroomsController < ApplicationController
	before_action :find_user
	before_action :find_chatroom, only: [:change_chatroom_background, :mute_chatroom, :leave_group, :my_chatroom_messages, :chatroom_details]
	
	# list of all chatroom from backend
	def get_chatroom
		render json: {code: 200, message: "successfully fetched chatrooms", chatrooms: Chatroom.all_chatrooms(@user) }
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
		chatroom = @user.chatrooms.includes(:messages).order('name asc')#.paginate(:page => params[:page], :per_page => params[:size])
		chatroom = chatroom.map{
			       |x| (x.slice('id', 'name', 'image')
			           .merge( last_message:  x.messages.present? ? x.messages.order('created_at desc').reverse.last.as_json(only: [:content]) : "", 
			           	#.merge( last_message: x.messages.order('created_at desc').reverse.last.as_json(only: [:content]), 
			                unread_count: (x.messages.reject{|m| m.is_read.include?("#{@user.id}") }).count)
			           ) 
			        }
                   #.paginate(:page => params[:page],
                   #:per_page => params[:size])
		#render json: {code: 200, message: "successfully fetched my chatrooms", my_chatrooms: chatroom, pagination: Paging.set_page(params[:page], params[:size], chatroom ) }
		render json: {code: 200, message: "successfully fetched my chatrooms", my_chatrooms: chatroom }

	end

	# change chatroom background
	def change_chatroom_background
		chatroom = UsersChatroom.get_user_chatroom @user, @chatroom
		chatroom.update(background_id: params[:background_id])
		get_response 200, "successfully updated background"
	end

	

	# create chatroom messages
	def create_chatroom_message
       return get_response 200, "chatroom not found"  if !Chatroom.find_chatroom(params[:message][:chatroom_id]).present?
		message = @user.messages.build(message_params @user)
		
		if message.save
			 p "=========#{message.inspect}"
			 User.group_chat_notification(@user,message)
			# message = message.slice('id','user_id','chatroom_id','content','media','is_read').merge(created_at: message.created_at.to_i)
			render json: {code: 200, message: "successfully created", create_chatroom_message: message  }

		else
			get_response 500, message.errors.full_messages.first.capitalize.to_s.gsub('_',' ') + "."
		end
	end

	# get my chatroom messages
	def my_chatroom_messages
		chatroom_messages = @chatroom.messages.includes(:user).map{|x| x.slice('id', 'user_id', 'chatroom_id', 'content').merge(user: x.user.username, created_at: x.created_at.to_i) }.sort_by{|e| e[:created_at]}.reverse.paginate(:page => params[:page], :per_page => params[:size])
		# chatroom_messages = @chatroom.messages.includes(:user).map{|x| x.slice('id', 'user_id', 'chatroom_id', 'content') }.order('created_at desc').paginate(:page => params[:page], :per_page => params[:size])
		Message.update_unread_message_status @user, @chatroom
		background = Background.find_by_id((UsersChatroom.get_user_chatroom(@user, @chatroom)).background_id)
		
		# my_read_msg = chatroom_messages.where("'?' = ANY (is_read)", @user.id).pluck(:id)
		# my_unread_messsages = 
		# my_unread_messsages = chatroom_messages.merge(my_read_msg)
		# my_unread_messsages.update_all(['is_read = is_read || ?::text', @user.id])
		render json: {code: 200, message: "successfully fetched my chatrooms", chatroom_messages: chatroom_messages.reverse, background: background.present? ? background.image.url : "", pagination: Paging.set_page(params[:page], params[:size], chatroom_messages ) }
	end

	# chatrom details 
	def chatroom_details
		chatroom_users = @chatroom.users.order('username asc')#.paginate(:page => params[:page], :per_page => params[:size])
		user_chat = UsersChatroom.get_user_chatroom @user, @chatroom
		render json: {code: 200, message: "successfully fetched my chatrooms", 
		chatroom_details: @chatroom.as_json(only: [:id, :name, :image]).merge(users: chatroom_users.as_json(only: [:id, :username, :image]), is_mute: user_chat.is_notified ) }
	end

	# leave this group
	def leave_group
		user_chat = UsersChatroom.get_user_chatroom @user, @chatroom
		return get_response 200, "already left group"  if !user_chat
		user_chat.delete
		get_response 200, "successfully left group"
	end

	# mute chat
	def mute_chatroom
		target_chat = UsersChatroom.get_user_chatroom @user, @chatroom
		return get_response 500, "you are no longer member for this chatroom"  if !target_chat
		 # target_chat.update(is_notified: target_chat.is_notified ? false : true) 
		target_chat.update(is_notified: params[:is_mute])
		get_response 200, "successfully updated"
	end

	# private methods
	private
	def message_params user
		params[:message][:is_read] = [user.id]
		params.require(:message).permit(:content, :media, :chatroom_id, :is_read=>[])
	end

end
