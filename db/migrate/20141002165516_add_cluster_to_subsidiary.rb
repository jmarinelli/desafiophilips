class AddClusterToSubsidiary < ActiveRecord::Migration
  def change
    add_column :subsidiaries, :cluster, :string
    remove_column :users, :cluster
  end
end
