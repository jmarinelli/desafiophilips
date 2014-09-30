class AddCorrectOptionToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :correct_option, :integer
  end
end
