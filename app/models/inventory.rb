class Inventory < ApplicationRecord
  belongs_to :user
  belongs_to :badge
end
