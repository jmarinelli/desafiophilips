class UpdateForSales < ActiveRecord::Migration
  def change
    remove_column :sales, :created_at
    remove_column :sales, :updated_at
    remove_column :products, :code
  end
end
