class User < ActiveRecord::Base
	self.primary_key = "dni"
	belongs_to :subsidiary
	belongs_to :company
end
