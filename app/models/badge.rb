class Badge < ApplicationRecord
  belongs_to :category
  belongs_to :collection

  has_many :inventories
  has_many :users, through: :inventories

  has_many :wishes
  has_many :wishers, through: :wishes, source: :user

  has_many :trade_badges
  has_many :trades, through: :trade_badges
end
