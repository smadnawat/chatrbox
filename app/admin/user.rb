ActiveAdmin.register User do
	actions :all, :except => [:new,:edit,:destroy]
    menu :priority => 2
  index do
    column :email
    column :username
    column :full_name
    column :fb_location
    column "Status" do |resource|
      status = resource.is_active
      status_tag (status ? "Active" : "Deactive"), (status ? :ok : :error) 
    end  
    column "Subscribed" do |resource|
      status = resource.is_subscribed
      status_tag (status ? "Yes" : "No"), (status ? :ok : :error) 
    end  
    column :image do |img|
      image_tag img.image_url(:admin_index)
    end
    column :created_at
    column "Actions" do |resource|
      links = ''.html_safe
      a do
        resource.is_active ? (links += link_to 'Deactive', change_user_status_path(resource, status: false),
        :data => { :confirm => 'Are you sure, you want to deactive this profile?' }) : 
        (links += link_to 'Active', change_user_status_path(resource, status: true),
        :data => { :confirm => 'Are you sure, you want to active this profile?' })
        links += " | "
        links += link_to 'Show', admin_user_path(resource)
      end
    end
  end

  filter :email
  filter :username
  filter :full_name

	show do |ad|
    attributes_table do	 
    row  :email 
    row  :username
    row  :full_name
    row  :fb_location
    row  :image do |img|
      image_tag img.image_url(:admin_show)
    end
    row  :created_at
   end
	end

end
