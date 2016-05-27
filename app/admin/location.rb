ActiveAdmin.register Location do
	permit_params :name, :flag_image
	# actions :all, :except => [:destroy]
  menu :priority => 6
  index do
    column :name
    column :flag_image do |img|
      image_tag img.flag_image_url(:admin_index)
    end
    column :created_at
    actions
  end

  filter :name

 	form do |f|
	  f.inputs do
	    f.input :name
	    f.input :flag_image,:as => :file
	    end
	  f.actions
  end

  show do |ad|
    attributes_table do	 
    row  :name 
    row  :flag_image do |img|
      image_tag img.flag_image_url(:admin_show)
    end
    row  :created_at
    row  :updated_at
   end
	end
end
