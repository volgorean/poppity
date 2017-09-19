class Trade < ApplicationRecord
  belongs_to :a, class_name: :user
  belongs_to :b, class_name: :user

  has_many :trade_badges
  has_many :badges, through: :trade_badges
end
