class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.references :score, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
