class Question < ActiveRecord::Base
  has_many :options
  belongs_to :correct_option, :class_name => 'Option'

  def as_json(options={})
    options[:only] ||= [:id, :text, :options]
    options[:include] ||= :options
    super(options)
  end
end