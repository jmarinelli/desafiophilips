class AddPointsToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :points, :integer
  end
end
