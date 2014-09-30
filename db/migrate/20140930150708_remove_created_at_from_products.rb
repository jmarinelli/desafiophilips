class RemoveCreatedAtFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :created_at
    remove_column :products, :updated_at
    remove_column :products, :score_id
    add_column :products, :score, :integer
  end
end
