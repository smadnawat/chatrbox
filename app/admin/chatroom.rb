ActiveAdmin.register Chatroom do
	permit_params :name, :image, :status, :is_multiple, :location_id
	actions :all, :except => [:destroy]
  menu :priority => 3
  index do
    column :name
    column :image do |img|
      image_tag img.image_url(:admin_index)
    end
    column :location
    column :created_at
    actions
  end

  filter :name

 	form do |f|
	  f.inputs do
	    f.input :name
	    f.input :image,:as => :file
	    f.input :location, input_html: {include_blank: false}
	    end
	  f.actions
  end

  show do |ad|
    attributes_table do	 
    row  :name 
    row  :image do |img|
      image_tag img.image_url(:admin_show)
    end
    row  :location
    row  :created_at
    row  :updated_at
   end
	end
end