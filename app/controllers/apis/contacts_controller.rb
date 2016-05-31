class Apis::ContactsController < ApplicationController
	before_action :find_user
	def contact_us
		contact = @user.contact_us.build(contact_params)
		if contact.save
			get_response 200, "successfully submitted"
		else
			get_response 500, contact.errors.full_messages.first.capitalize.to_s.gsub('_',' ') + "."
		end
	end
	private
	def contact_params
		params.require(:contact).permit(:subject, :description)
	end
end
