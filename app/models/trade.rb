class Trade < ApplicationRecord
  belongs_to :a, class_name: :User
  belongs_to :b, class_name: :User

  has_many :trade_badges
  has_many :badges, through: :trade_badges

  validates :a, presence: true
  validates :b, presence: true
end
