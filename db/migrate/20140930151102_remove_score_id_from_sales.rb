class RemoveScoreIdFromSales < ActiveRecord::Migration
  def change
    remove_column :sales, :score_id
    add_reference :sales, :product, index: true
  end
end
