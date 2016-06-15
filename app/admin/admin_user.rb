ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation ,:role
  #actions :all, :except => [:destroy]
  menu :priority => 2
  index do
    # selectable_column
    # id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email

  form do |f|
    f.inputs "Admin Details" do
      f.input :email ,input_html: { autofocus: true }, placeholder: "Please enter email id"
      f.input :password ,placeholder: "Please enter password"
      f.input :password_confirmation
    end
    f.actions 
  end

  controller do
    def scoped_collection
      AdminUser.where(:role => "admin_user")
    end
  end





end
