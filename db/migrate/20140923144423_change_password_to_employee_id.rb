class ChangePasswordToEmployeeId < ActiveRecord::Migration
  def change
    rename_column :users, :password, :employee_file_number
  end
end
