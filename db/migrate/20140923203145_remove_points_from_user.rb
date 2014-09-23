class RemovePointsFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :points, :created_at, :updated_at
  end
end
