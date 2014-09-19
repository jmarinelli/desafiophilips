class CreateSubsidiaries < ActiveRecord::Migration
  def change
    create_table :subsidiaries do |t|
      t.integer :code
      t.string :name

      t.timestamps
    end
  end
end
