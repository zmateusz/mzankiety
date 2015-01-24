class Poll < ActiveRecord::Base
  belongs_to :survey
  has_many :answers, dependent: :destroy
  has_many :votes, through: :answers

  validates :name, :typ, presence: true
  validates :descr, length: { maximum: 500 }  
  validates :name, 
            uniqueness: true,
            length: { maximum: 70 }
end
