class Badge < ApplicationRecord
  belongs_to :category, counter_cache: true
  belongs_to :collection, counter_cache: true

  has_many :inventories
  has_many :users, through: :inventories

  has_many :wishes
  has_many :wishers, through: :wishes, source: :user

  has_many :trade_badges
  has_many :trades, through: :trade_badges
end
