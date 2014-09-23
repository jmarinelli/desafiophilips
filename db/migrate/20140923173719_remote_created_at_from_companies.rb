class RemoteCreatedAtFromCompanies < ActiveRecord::Migration
  def change
    remove_column :companies, :updated_at, :created_at
  end
end
