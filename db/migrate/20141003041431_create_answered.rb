class CreateAnswered < ActiveRecord::Migration
  def change
    create_table :answered_questions do |t|
      t.belongs_to :user, index: true
      t.belongs_to :question, index: true
    end
  end
end
