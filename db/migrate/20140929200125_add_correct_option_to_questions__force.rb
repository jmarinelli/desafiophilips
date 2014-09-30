class AddCorrectOptionToQuestionsForce < ActiveRecord::Migration
  def change
    add_reference :questions, :option
  end
end
