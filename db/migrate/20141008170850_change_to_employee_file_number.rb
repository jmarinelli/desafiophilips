class ChangeToEmployeeFileNumber < ActiveRecord::Migration
  def change
    remove_column :sales, :user_id
    add_column :sales, :user_employee_file_number, :string
  end
end
