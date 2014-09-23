class RemoveIdleColumns < ActiveRecord::Migration
  def change
    remove_column :users, :created_at
    remove_column :users, :updated_at
    remove_column :companies, :created_at
  end
end
