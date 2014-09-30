class RemoveOptionsFromQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :options
    remove_column :questions, :correct_option
  end
end
