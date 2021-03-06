class User < ActiveRecord::Base
  attr_accessor :ranking
  belongs_to :subsidiary
  belongs_to :company
  belongs_to :position
  has_many :sales, :foreign_key => 'user_employee_file_number', :primary_key => 'employee_file_number'
  has_many :answered_questions
  has_many :questions, through: :answered_questions

  def self.top(company, cluster_id, position, limit)
    User.select("users.id, trivia_points, users.name, dni, employee_file_number, coalesce(sum(tablita.score * tablita.amount),0) + trivia_points as points, subsidiary_id")
        .joins("LEFT OUTER JOIN (select * from sales LEFT OUTER JOIN products ON sales.product_id = products.id where sales.product_id IN (select id from products)) as tablita ON tablita.user_employee_file_number = users.employee_file_number")
        .joins("JOIN subsidiaries ON users.subsidiary_id = subsidiaries.id").where("subsidiaries.cluster = '" + cluster_id + "'")
        .where(company_id: company).where(position_id: position).group("users.id").order("points desc").limit(limit)
  end

  # REVISAR
  def ranking
    top = User.top(self.company.id, self.subsidiary.cluster, self.position.id, nil)
    top.index{ |u| u.id == self.id } + 1
  end

  def points
    self.sales.inject(0){ |acum, s| 
      unless s.product.nil?
        acum += s.product.score * s.amount
      end
      acum
    } + self.trivia_points
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
