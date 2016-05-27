class Apis::UsersController < ApplicationController
	before_action :find_user, only: [:sign_out, :about, :term, :faq, :get_location]
	# create user adn log into the app
	def create
		user = User.where(fb_id: params[:users][:fb_id]).first
		if user.present?
			user.email = params[:users][:email] if params[:users][:email].present?
			user.username = params[:users][:username] if params[:users][:username].present?
			user.full_name = params[:users][:full_name] if params[:users][:full_name].present?
			user.fb_location = params[:users][:fb_location] if params[:users][:fb_location].present?
			user.image = User.image_data(params[:users][:image]) if params[:users][:image].present?
			user.profile_status = params[:users][:profile_status] if params[:users][:profile_status].present?
			user.authentication_token = Time.now.to_i.to_s+SecureRandom.hex
		else
			user = User.new(users_params)
		end
		if user.save
			gadget = user.gadgets.where(gadget_id: params[:users][:gadget_id]).first
			user.gadgets.create(gadget_id: params[:users][:gadget_id]) if !(gadget.present?&&params[:users][:gadget_id].present?)
			render json: {code: 200, message: "successfully logged in", user: user}
		else
			get_response 500, user.errors.full_messages.first.capitalize.to_s.gsub('_',' ') + "."
		end
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
	# list of all location from backend
	def get_location
		render json: {code: 200, message: "successfully fetched faq", locations: Location.all_locations(@user, params[:page], params[:size]) }#.merge(user: @user.id) } #.as_json(only: [:name, :flag_image])
	end
	# call from admin panel to update user status
	def change_user_status
		User.where(id: params[:format]).first.update(is_active: params[:status])
		redirect_to :back, :notice => "status updated successfully"
	end
	# private methods
	private
	def users_params
		params[:users][:authentication_token] = Time.now.to_i.to_s+SecureRandom.hex
		params[:users][:image] = User.image_data(params[:users][:image]) if params[:users][:image].present?
		params.require(:users).permit(:email, :username, :full_name, :fb_location, :image, :profile_status, :fb_id, :authentication_token)
	end
end
