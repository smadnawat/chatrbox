class Apis::FriendsController < ApplicationController
	before_action :find_user
	before_action :find_member ,except: [:get_my_friend_list,:get_blocked_friends,:search_friend]



	def send_message_to_friend
			friend = Friend.find_by(user_id: @user.id, member_id: @member.id,is_added: true)
			Friend.create_friend @user.id, @member.id if friend.blank?
			chat = SingleChatMessage.new(single_chat_message_params @user)
			
		if chat.save
			chat =  chat.slice('id', 'user_id', 'member_id', 'message').merge!(username: User.find_by_id(chat.user_id).username, created_at: chat.created_at.to_i, media: chat.media.present? ? chat.media.url : "" )
			User.single_chat_notification(@user,@member,chat) 
			#chat =  chat.slice('id', 'user_id', 'member_id', 'message').merge!(username: User.find_by_id(chat.user_id).username, created_at: chat.created_at.to_i, media: chat.media.present? ? chat.media.url : "" )
		    render json: {code: 200 , message: "message successfully sent" , is_mute: (Friend.find_by(user_id: @user.id,member_id: @member.id)).is_notified ,chat:chat}	
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

           if !(SingleChatMessage.is_exist(@user.id,params[:member_id]))
                 render json: {code: 200, message: "successfully fetched friends messages",friends_messages: {},background: ""} 
           else
				SingleChatMessage.update_read_status @user.id, params[:member_id]
				messages = SingleChatMessage.get_messages(@user.id, params[:member_id], params[:page], params[:size])
				friend_messages = messages.map{
					                           |x| x.slice('id', 'user_id', 'member_id', 'message')
					                                .merge!(username: User.find_by_id(x.user_id).username, 
					                             	created_at: x.created_at.to_i, media: x.media.present? ? x.media.url : "" ) 
					                          }
					                          .sort_by{|e| e[:created_at]}
					                          .reverse.paginate(:page => params[:page], :per_page => params[:size])

		        background = Background.find_by_id(Friend.find_by(user_id: @user.id,member_id: params[:member_id]).background_id)
		        render json: {code: 200, message: "successfully fetched friends messages", friends_messages: friend_messages,background: background.present? ? background.image.url : "", pagination: Paging.set_page(params[:page], params[:size] ,messages) }

           end
 
	end



#change single chat room background
	def change_single_chat_background
			friend = Friend.find_friend(@user.id, params[:member_id])
			friend.update_all(background_id: params[:background_id])
			# render json: {code: 200, message: "successfully updated background", background: Background.find_by_id(params[:background_id]) }
		    get_response 200 , "successfully updated "
	end





 #get all my friend list
	def get_my_friend_list
			friends=Friend.friend_list(@user) #,params[:page],params[:size])
	         #last_message = SingleChatMessage.where(user_id: friend.id,member_id: @user.id).order('created_at desc').reverse.last

	         #render json: {code: 200 , message: "successfully fetched friend list",friend_list: friends.map{ |friend| friend.as_json(only: [:id,:username,:image,:profile_status]).merge(unread_count: SingleChatMessage.where(user_id: friend.id,member_id: @user.id,is_read: false).count) },pagination: Paging.set_page(params[:page], params[:size], friends )}
	        render json: { 
	       	              code: 200 ,
	                      message: "successfully fetched friend list",
	                      friend_list: friends.map{ 
	                      	                        |friend| friend.as_json(only: [:id,:full_name,:profile_status])
	                      	                         .merge(unread_count: SingleChatMessage.where(user_id: friend.id,member_id: @user.id,is_read: false).count ,
	                      	                         	image: friend.image.present? ? friend.image.url : "" ,
	                      	                         	last_message:  SingleChatMessage.where(user_id: friend.id,member_id: @user.id).present? ? SingleChatMessage.where(user_id: friend.id,member_id: @user.id).order('created_at desc').reverse.last.message
	                                                                      .as_json(only: [:message]) : "") 
	                      	                       }
	                     }

	end










 #search friend
    def search_friend
	       #friends=Friend.search(@user,params[:username],params[:page],params[:size])
	       friends=Friend.search(@user,params[:username])
	       #render json: {code: 200 , message: "successfully fetched friend list",friend_list: friends.map{ |friend| friend.as_json(only: [:id,:username,:image,:profile_status]).merge(unread_count: SingleChatMessage.where(user_id: friend.id,member_id: @user.id,is_read: false).count) },pagination: Paging.set_page(params[:page], params[:size], friends )}
	       render json: {
	       	              code: 200 , message: "successfully fetched friend list",
	       	              friend_list: friends.map{ 
	       	                                       |friend| friend.as_json(only: [:id,:username,:image,:profile_status])
	       	                                       .merge(unread_count: SingleChatMessage.where(user_id: friend.id,member_id: @user.id,is_read: false).count) 
	       	                                       }
	       	            }

    end






  
 #get block listed users
    def get_blocked_friends
	       friends=Friend.block_list(@user)
	       render json: { 
	       	              code: 200 , 
	       	              message: "successfully fetched block list" , 
	       	              block_list: friends.map{ |friend| friend.as_json(only: []).merge(name: User.find_by_id(friend.member_id).full_name,member_id: friend.member_id) }
	       	            }	
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
  	    @friend = Friend.find_by(user_id: @user.id , member_id: params[:member_id])
  	    #@friend.is_notified ? @friend.update(is_notified:false) : @friend.update(is_notified: true)
        @friend.update(is_notified: @friend.is_notified? ? false : true)
	  	#Friend.find_by(user_id: @user.id , member_id: params[:member_id]).update(is_notified: false)
	    get_response 200, "successfully updated"
  end





#find friendship b
  def find_friendship
	  	  friend=Friend.find_by(user_id: @user.id , member_id: params[:member_id])
	  	  if friend.present?
			  	  	  background = Background.find_by(id: friend.background_id)
			  	  	  @profile_details = Hash.new
			          @profile_details = {
			           	                    "is_friend" =>friend.is_added ,
			           	                    "is_blocked" => friend.is_block ,
			           	                    "profile" =>@member.image.url.present? ? @member.image.url : "" ,
			           	                    "username" => @member.username,
			           	                    "is_mute" =>friend.is_notified ,
			           	                    "background" => background.present? ? background.image.url : "" 
			                              }
			           render json: {code: 200 , user_details: @profile_details.as_json ,message: "successfully fetched user details"}	
		 else
	      	@user_details = Hash.new 
	      	@user_details = {
	                        "is_friend" => false,
	                        "is_blocked" => false ,
	                        "profile" => @member.image.url.present? ? @member.image.url : "" ,
	                        "username" => @member.username ,
	                        "is_mute" => false ,
	                        "background" => ""
	                        }
	      	 render json: {code: 200 , user_details: @user_details.as_json ,message: "successfully fetched user details"}	
	     end
  end






 private
	def single_chat_message_params user
		params[:single_chat_message][:user_id] = @user.id
		params[:single_chat_message][:member_id] = @member.id	
		params[:single_chat_message][:media] = SingleChatMessage.media_data(params[:single_chat_message][:media]) if params[:single_chat_message][:media].present?
		params.require(:single_chat_message).permit(:member_id, :message, :media,:user_id)
	end
end
