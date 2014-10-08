class Subsidiary < ActiveRecord::Base
  attr_accessor :manager
  attr_accessor :sub_manager
	has_many :users
	belongs_to :company

  def self.top(company, limit)
    Subsidiary.select("subsidiaries.id, subsidiaries.name, subsidiaries.cluster, coalesce(sum(products.score * sales.amount),0) as points")
              .joins(:users).joins("LEFT OUTER JOIN sales ON sales.user_employee_file_number = users.employee_file_number LEFT OUTER JOIN products ON sales.product_id = products.id")
              .where(company_id: company).where("sales.product_id IN (select id from products)").group("subsidiaries.id")
              .order("points desc").limit(limit)
  end

  def manager
    User.select("id, name, employee_file_number, dni").where(subsidiary_id: self.id).where(position_id: 3).take
  end

  def sub_manager
    User.select("id, name, employee_file_number, dni").where(subsidiary_id: self.id).where(position_id: 2).take
  end

  def as_json(options={})
    options[:except] ||= [:created_at, :updated_at]
    super(options)
  end
end
