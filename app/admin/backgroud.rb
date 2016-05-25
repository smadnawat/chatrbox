ActiveAdmin.register Backgroud do
	permit_params :name, :image
	actions :all, :except => [:destroy]
  menu :priority => 4
  index do
    column :name
    column :image
    actions
  end

  filter :name

 	form do |f|
	  f.inputs do
	    f.input :name
	    f.input :image
	    end
	  f.actions
  end

  show do |ad|
    attributes_table do	 
    row  :name 
    row  :image
    row  :created_at
    row  :updated_at
   end
	end

end
