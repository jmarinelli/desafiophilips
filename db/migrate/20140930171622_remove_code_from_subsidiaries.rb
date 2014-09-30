class RemoveCodeFromSubsidiaries < ActiveRecord::Migration
  def change
    remove_column :subsidiaries, :code
  end
end
