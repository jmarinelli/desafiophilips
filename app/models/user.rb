class User < ActiveRecord::Base
  attr_accessor :ranking
  belongs_to :subsidiary
  belongs_to :company
  belongs_to :position
  has_many :sales
  has_many :answered_questions
  has_many :questions, through: :answered_questions

  def self.top(company, cluster_id, position, limit)
    User.select("users.id, trivia_points, users.name, dni, employee_file_number, coalesce(sum(products.score),0) as points, subsidiary_id")
        .joins("LEFT OUTER JOIN sales ON sales.user_id = users.id LEFT OUTER JOIN products ON sales.product_id = products.id")
        .joins("JOIN subsidiaries ON users.subsidiary_id = subsidiaries.id").where("subsidiaries.cluster = '" + cluster_id + "'")
        .where(company_id: company).where(position_id: position).group("users.id").order("points desc").limit(limit)
  end

  # REVISAR
  def ranking
    @top_users = User.select("users.name, trivia_points, coalesce(sum(products.score), 0) as points")
                     .joins("LEFT OUTER JOIN sales ON sales.user_id = users.id LEFT OUTER JOIN products ON sales.product_id = products.id")
                     .where(company_id: self.company_id).where(position_id: self.position_id).group("users.id")
                     .having("coalesce(sum(products.score),0) > ?", self.points)
    @top_users.length + 1
  end

  def points
    self.sales.inject(0){ |acum, s| acum = acum + s.product.score } + self.trivia_points
  end

  def add_trivia_points(points)
    self.update(:trivia_points => self.trivia_points += points)
  end

  def answered_questions_ids
    self.answered_questions.map { |question| question.question_id }
  end

  def as_json(options={})
    options[:except] ||= [:created_at, :updated_at]
    super(options)
  end
end
