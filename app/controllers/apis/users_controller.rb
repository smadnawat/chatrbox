class Apis::UsersController < ApplicationController
	before_action :find_user, only: [:sign_out, :get_chatroom, :update, :get_background, :show]
	
	# check user exist or not
	def login
		user = User.find_by_fb_id(params[:fb_id])
		if user
			Gadget.find_and_create_gadget(user, params[:gadget_id]) if params[:gadget_id].present?
			render json: {code: 200, message: "successfully logged in", user: user.as_json.merge(is_exist: true) }
		else
			render json: {code: 500, message: "user does not exist", is_exist: false}
		end
	end

	# create user adn log into the app
	def create
		user = User.new(users_params)
		if user.save
			user.locations << Location.find_by_id(params[:users][:location_id]) if params[:users][:location_id].present? #and !user.locations.present?)
			Gadget.find_and_create_gadget(user, params[:users][:gadget_id]) if !params[:users][:gadget_id].present?
			render json: {code: 200, message: "successfully logged in", user: user}
		else
			get_response 500, user.errors.full_messages.first.capitalize.to_s.gsub('_',' ') + "."
		end
	end

	# update the user
	def update
		user = @user.update(users_params)
		if user
			render json: {code: 200, message: "successfully logged in", user: @user}
		else
			get_response 500, @user.errors.full_messages.first.capitalize.to_s.gsub('_',' ') + "."
		end
	end

	# get user profile
	def show
		render json: {code: 200, message: "successfully fetched profile", profile: @user.as_json.merge( location: @user.locations.last ) }
	end
	
	# sign out user with delete its authentication token
	def sign_out
		@user.update(authentication_token: "")
		@user.gadgets.where(gadget_id: params[:gadget_id]).destroy_all
		get_response 200, "successfully logged out"
	end
	
	# static content methos
	def about; render json: {code: 200, message: "successfully fetched about", about: StaticPage.where(title: "About").last.as_json(only: [:title, :content])}; end
	def term; render json: {code: 200, message: "successfully fetched term", term: StaticPage.where(title: "Term and Policy").last.as_json(only: [:title, :content])}; end
	def faq; render json: {code: 200, message: "successfully fetched faq", faq: StaticPage.where(title: "FAQ").last.as_json(only: [:title, :content])}; end
	def home; end
	
	# list of all location from backend
	def get_location
		# get_locations = Location.all_locations(params[:page], params[:size])
		render json: {code: 200, message: "successfully fetched locations", locations: Location.all_locations }
	end
	
	# list of all background from backend
	def get_background
		get_locations = Background.all_backgrounds(@user, params[:page], params[:size])
		render json: {code: 200, message: "successfully fetched backgrounds",locations: get_locations.first, pagination: get_locations.last }
	end

	# call from admin panel to update user status
	def change_user_status
		User.where(id: params[:format]).first.update(is_active: params[:status])
		redirect_to :back, :notice => "status updated successfully"
	end


	# #list of all user's friend

	# def my_friends
	# 	friends = Friends.where(user_id:  params[:id] , member_id: params[:id])
	# 	render json:{code:200, message: "successfully fetched usser's friends", my_friends: friends}

	# end


	# Report to admin for abusive behavior of other member user
      
      def create_report
      	 user_report = Report.create(user_id: params[:id],member_id: params[:member_id] ,content:params[:content] ) 
      	 get_response 200, "report successfully submitted"
      end
	
	# private methods
	private
	def users_params
		params[:users][:authentication_token] = Time.now.to_i.to_s+SecureRandom.hex
		params[:users][:image] = User.image_data(params[:users][:image]) if params[:users][:image].present?
		params.require(:users).permit(:email, :username, :full_name, :fb_location, :image, :profile_status, :fb_id, :authentication_token)
	end
end
