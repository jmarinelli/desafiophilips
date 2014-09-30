class AddTriviaPointsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :trivia_points, :integer
  end
end
