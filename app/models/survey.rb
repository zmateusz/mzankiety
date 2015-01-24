class Survey < ActiveRecord::Base
  has_many :polls, dependent: :destroy
  has_many :votes, through: :polls

  validates :name, 
            presence: true, 
            uniqueness: true,
            length: { maximum: 70 }
  validates :descr, length: { maximum: 500 }      
end
