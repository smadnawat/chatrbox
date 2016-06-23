class Apis::FriendsController < ApplicationController
	before_action :find_user
	before_action :find_member ,except: [:get_my_friend_list,:get_blocked_friends,:search_friend]



	def send_message_to_friend
			friend = Friend.find_by(user_id: @user.id, member_id: @member.id,is_added: true)
			Friend.create_friend @user.id, @member.id if friend.blank?
			chat = SingleChatMessage.new(single_chat_message_params @user)
		if chat.save
			User.single_chat_notification(@user,@member,chat.message) 
		    render json: {code: 200 , message: "message successfully sent" , is_mute: (Friend.find_by(user_id: @user.id,member_id: @member.id)).is_notified}	
        else
			get_response 500, chat.errors.full_messages.first.capitalize.to_s.gsub('_',' ') + "."
		end
	end


#add or block to user
	def add_block_friend
	    friends = Friend.find_by(user_id: @user.id, member_id: @member.id)
        Friend.create_friend @user.id, @member.id if friends.blank?
        if (params[:friend] == "add")
			friend = Friend.where("(user_id = ? and member_id = ?) or (user_id = ? and member_id = ?) ", @user.id,@member.id,@member.id,@user.id).update_all(is_added: true)
		else
		 friend = Friend.find_friend(@user.id, params[:member_id])
         friend.update_all(is_block: true,is_added:false)
         friend = Friend.find_friend(params[:member_id],@user.id)
         friend.update_all(is_added:false)
		end
		get_response 200, "member successfully #{params[:friend]}ed"
	end

#get one to one chat messages
	def get_friend_messages
		SingleChatMessage.update_read_status @user.id, params[:member_id]
		messages = SingleChatMessage.get_messages(@user.id, params[:member_id], params[:page], params[:size])
        background =Background.find_by_id(Friend.find_by(user_id: @user.id,member_id: params[:member_id]).background_id)
        render json: {code: 200, message: "successfully fetched friends messages", friends_messages: messages,background: background.present? ? background : {}, pagination: Paging.set_page(params[:page], params[:size], messages ) }
	end

#change single chat room background
	def change_single_chat_background
		friend = Friend.find_friend(@user.id, params[:member_id])
		friend.update_all(background_id: params[:background_id])
		get_response 200, "successfully updated background"
	end

 #get all my friend list
	def get_my_friend_list
		friends=Friend.friend_list(@user,params[:page],params[:size])
       render json: {code: 200 , message: "successfully fetched friend list",friend_list: friends.map{ |friend| friend.as_json(only: [:id,:username,:image,:profile_status]).merge(unread_count: SingleChatMessage.where(user_id: friend.id,member_id: @user.id,is_read: false).count) },pagination: Paging.set_page(params[:page], params[:size], friends )}
	end

 #search friend
    def search_friend
       friends=Friend.search(@user,params[:username],params[:page],params[:size])
       render json: {code: 200 , message: "successfully fetched friend list",friend_list: friends.map{ |friend| friend.as_json(only: [:id,:username,:image,:profile_status]).merge(unread_count: SingleChatMessage.where(user_id: friend.id,member_id: @user.id,is_read: false).count) },pagination: Paging.set_page(params[:page], params[:size], friends )}
    end

  
 #get block listed users
    def get_blocked_friends
       friends=Friend.block_list(@user)
       render json: {code: 200 , message: "successfully fetched block list" , block_list: friends.map{ |friend| friend.as_json(only: []).merge(name: User.find_by_id(friend.member_id).full_name,member_id: friend.member_id) }}	
    end	

  #unblock friend
   def unblock_friend
   	  friend = Friend.find_friend(@user.id, params[:member_id])
      friend.update_all(is_block: false,is_added:true)
      friend = Friend.find_friend(params[:member_id],@user.id)
      friend.update_all(is_added: true)
      get_response 200, "#{@member.full_name} is successfully added to your friend list "
   end

 #mute single chat

  def mute_single_chat
	  	Friend.find_by(user_id: @user.id , member_id: params[:member_id]).update(is_notified: false)
	    get_response 200, "successfully updated"
  end

  def find_friendship
  	  friend=Friend.find_by(user_id: @user.id , member_id: params[:member_id])

  	  if friend.present?
         render json: {code: 200 , is_friend: friend.is_added,is_blocked:friend.is_block ,profile: @member.image , username: @member.username}	
      else
      	 render json: {code: 200 , is_friend: false , is_blocked: false,profile: @member.image , username: @member.username}	
      end
  end


 private
	def single_chat_message_params user
		params[:single_chat_message][:user_id] = @user.id
		params[:single_chat_message][:member_id] = @member.id
		params.require(:single_chat_message).permit(:member_id, :message, :media,:user_id)
	end
end
