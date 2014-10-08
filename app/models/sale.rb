class Sale < ActiveRecord::Base
  belongs_to :product
  belongs_to :user, :foreign_key => 'employee_file_number', :primary_key => 'user_employee_file_number'
end
