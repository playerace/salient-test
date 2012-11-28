class Contact < ActiveRecord::Base
  attr_accessible :firstName, :lastName

  validates :firstName, :presence => true
  validates :lastName, :presence => true

  has_many :contact_numbers
end
