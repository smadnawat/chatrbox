ActiveAdmin.register ContactU do
	actions :all, :except => [:destroy,:new,:create,:edit]
  menu :priority => 5
  index do
    column :subject
    column :description
    column :user
    column :created_at
    actions
  end

  filter :subject

  show do |ad|
    attributes_table do	 
    row  :subject 
    row  :description
    row  :user
    row  :created_at
    row  :updated_at
   end
	end
end
