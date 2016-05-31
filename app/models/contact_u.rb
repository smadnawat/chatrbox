class ContactU < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :subject, :description
end
