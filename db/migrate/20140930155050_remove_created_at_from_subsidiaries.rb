class RemoveCreatedAtFromSubsidiaries < ActiveRecord::Migration
  def change
    remove_column :subsidiaries, :created_at
    remove_column :subsidiaries, :updated_at
  end
end
