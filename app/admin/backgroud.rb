ActiveAdmin.register Background do
	permit_params :name, :image
	# actions :all, :except => [:destroy]
  menu :priority => 4
  index do
    column :name
    column :image do |img|
      image_tag img.image_url(:admin_index)
    end
    column :created_at
    actions
  end

  filter :name

 	form do |f|
	  f.inputs do
	    f.input :name
      f.input :image,:as => :file
	    end
	  f.actions
  end

  show do |ad|
    attributes_table do	 
    row  :name 
    row  :image do |img|
      image_tag img.image_url(:admin_show)
    end
    row  :created_at
    row  :updated_at
   end
	end

end
