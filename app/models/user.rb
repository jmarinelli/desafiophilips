class User < ActiveRecord::Base
  attr_accessor :ranking
  belongs_to :subsidiary
  belongs_to :company
  belongs_to :position
  has_many :sales

  def self.top(company, position, limit)
    User.select("users.id, name, dni, employee_file_number, coalesce(sum(scores.value),0) as points, subsidiary_id")
        .joins("LEFT OUTER JOIN sales ON sales.user_id = users.id LEFT OUTER JOIN scores ON sales.score_id = scores.id")
        .where(company_id: company).where(position_id: position).group("users.id").order("points desc").limit(limit)
  end

  # REVISAR
  def ranking
    @top_users = User.select("name, coalesce(sum(scores.value), 0) as points")
                     .joins("LEFT OUTER JOIN sales ON sales.user_id = users.id LEFT OUTER JOIN scores ON sales.score_id = scores.id")
                     .where(company_id: self.company_id).where(position_id: self.position_id).group("users.id")
                     .having("coalesce(sum(scores.value),0) > ?", self.points)
    @top_users.length + 1
  end

  def points
    self.sales.inject(0){ |acum, s| acum = acum + s.score.value }
  end

  def to_json(options={})
   options[:except] ||= [:subsidiary_id, :company_id, :created_at, :updated_at]
   super(options)
 end
end
