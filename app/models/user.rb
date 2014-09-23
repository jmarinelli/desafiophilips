class User < ActiveRecord::Base
  attr_accessor :ranking
  belongs_to :subsidiary
  belongs_to :company
  belongs_to :position
  has_many :sales

  def get_points
    self.sales.inject(0){ |acum, s| acum = acum + s.score.value }
  end

  def to_json(options={})
   options[:except] ||= [:subsidiary_id, :company_id, :created_at, :updated_at]
   super(options)
 end
end
