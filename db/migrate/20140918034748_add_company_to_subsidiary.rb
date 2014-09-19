class AddCompanyToSubsidiary < ActiveRecord::Migration
  def change
    add_reference :subsidiaries, :company, index: true
  end
end
