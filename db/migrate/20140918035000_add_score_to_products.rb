class AddScoreToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :score, index: true
  end
end
