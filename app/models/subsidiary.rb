class Subsidiary < ActiveRecord::Base
	self.primary_key = "code"
	has_many :users
	belongs_to :company
end
