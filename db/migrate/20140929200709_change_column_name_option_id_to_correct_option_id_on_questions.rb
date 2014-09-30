class ChangeColumnNameOptionIdToCorrectOptionIdOnQuestions < ActiveRecord::Migration
  def change
    rename_column :questions, :option_id, :correct_option_id
  end
end
