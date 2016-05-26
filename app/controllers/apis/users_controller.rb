class Apis::UsersController < ApplicationController


	def change_user_status
		User.where(id: params[:format]).first.update(is_active: params[:status])
		redirect_to :back, :notice => "Status updated successfully"
	end
end
