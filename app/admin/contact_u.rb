ActiveAdmin.register ContactU, as: "Contact Us" do
	batch_action :destroy, false
	actions :all, :except => [:new,:create,:edit]
  menu :priority => 5
  index do
    column :subject
    column :description
    column :user
    column :created_at
    actions
  end

  filter :subject

  show :title => "Contact Us" do
    attributes_table do	 
    row  :subject 
    row  :description
    row  :user
    row  :created_at
    row  :updated_at
   end
	end
end
