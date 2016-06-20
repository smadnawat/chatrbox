ActiveAdmin.register Report do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

actions :all, :except => [:new,:edit,:destroy]
  index do
  column  :user do |user|
  	User.find_by_id(user.user_id).full_name
   end
    column  :member do |mem|
  	User.find_by_id(mem.member_id).full_name
    end
    actions
  end


end
