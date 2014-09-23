class Subsidiary < ActiveRecord::Base
	self.primary_key = "code"
  attr_accessor :manager
  attr_accessor :sub_manager
	has_many :users
	belongs_to :company

  def to_json(options={})
    options[:except] ||= [:company_id, :created_at, :updated_at]
    super(options)
  end
end
