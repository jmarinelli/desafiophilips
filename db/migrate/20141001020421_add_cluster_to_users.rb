class AddClusterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cluster, :integer
  end
end
