class TradeBadge < ApplicationRecord
  belongs_to :trade
  belongs_to :badge
  belongs_to :user
end
