class Answer < ActiveRecord::Base
  belongs_to :poll
  has_many :votes, dependent: :destroy
  before_save :default_values
  def default_values
    self.counter ||= 0
  end
end
