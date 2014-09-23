class Company < ActiveRecord::Base
	has_many :users
	has_many :subsidiaries

  def to_json(options={})
    options[:except] ||= [:created_at, :updated_at]
    super(options)
  end
end
