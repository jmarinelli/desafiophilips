class AddSubsidiaryToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :subsidiary, index: true
  end
end
