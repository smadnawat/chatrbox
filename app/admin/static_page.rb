ActiveAdmin.register StaticPage do

	actions :all, :except => [:new,:destroy, :show]
  menu :priority => 7
  index do
    column :title
    column :content
    actions
  end

  filter :title

 	form do |f|
	  f.inputs do
	    f.input :title, input_html: {readonly: true}
	    f.input :content
	    end
	  f.actions
  end


end
