ActiveAdmin.register Chatroom do
	permit_params :name, :image, :status, :is_multiple, :location_id
	actions :all, :except => [:destroy]
  menu :priority => 3
  index do
    column :name
    column :image
    column :created_at
    column :location, input_html: {include_blank: false}
    actions
  end

  filter :name

 	form do |f|
	  f.inputs do
	    f.input :name
	    f.input :image
	    f.input :location
	    end
	  f.actions
  end

  show do |ad|
    attributes_table do	 
    row  :name 
    row  :image
    row  :location
    row  :created_at
    row  :updated_at
   end
	end
end
