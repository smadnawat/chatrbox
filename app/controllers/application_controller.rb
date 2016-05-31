class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  def get_response code, message
		render json: {response_code: code, response_message: message}
  end

	def find_user
		@user = User.where(id: params[:id], authentication_token: request.headers["HTTP_TOKEN"], is_active: true).last
		return get_response 500, "you are not authorise user to perform this action" if !@user.present?
	end

end
