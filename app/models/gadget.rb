class Gadget < ActiveRecord::Base
  belongs_to :user

  def self.find_and_create_gadget user, id
  	gad = where(user_id: user.id, gadget_id: id).first
  	create(user_id: user.id, gadget_id: id) if !gad.present?
  end
end
