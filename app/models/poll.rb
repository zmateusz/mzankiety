class Poll < ActiveRecord::Base
  belongs_to :survey
  has_many :answers, dependent: :destroy
  has_many :votes, :through => :answers
  # paginates_per 2

  validates :name, :typ, presence: true
end

