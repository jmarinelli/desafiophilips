class Product < ActiveRecord::Base
	self.primary_key = "code"
  belongs_to :score
end
