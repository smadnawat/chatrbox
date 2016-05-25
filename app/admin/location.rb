ActiveAdmin.register Location do
	permit_params :name, :flag_image
	actions :all, :except => [:destroy]
  menu :priority => 6
  index do
    column :name
    column :flag_image
    actions
  end

  filter :name

 	form do |f|
	  f.inputs do
	    f.input :name
	    f.input :flag_image
	    end
	  f.actions
  end

  show do |ad|
    attributes_table do	 
    row  :name 
    row  :flag_image
    row  :created_at
    row  :updated_at
   end
	end
end
