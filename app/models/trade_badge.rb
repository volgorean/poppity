class TradeBadge < ApplicationRecord
  belongs_to :trade
  belongs_to :inventory
end
