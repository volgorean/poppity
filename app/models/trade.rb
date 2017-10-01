class Trade < ApplicationRecord
  belongs_to :a, class_name: :User
  belongs_to :b, class_name: :User

  has_many :trade_badges, dependent: :destroy
  has_many :badges, through: :trade_badges

  validates :a, presence: true
  validates :b, presence: true

  before_save :transfer_inventory, if: :a_recieved_changed?
  before_save :transfer_inventory, if: :b_recieved_changed?

  def other(user)
    a == user ? b : a
  end

  def status
    if self.closed
      "Closed"
    elsif self.a_accepts & self.b_accepts
      "Accepted"
    elsif self.a_sent & self.b_sent
      "Sending"
    elsif self.a_recieved & self.b_recieved
      "Recieved"
    else
      "Open"
    end
  end

  def transfer_inventory
    return if !(a_recieved && b_recieved) || closed

    ActiveRecord::Base.transaction do
      self.trade_badges.each do |tb|
        other_id = tb.user_id == a_id ? b_id : a_id

        i = Inventory.find_or_initialize_by(user_id: other_id, badge_id: tb.badge_id)
        i.number ||= 0
        i.number += tb.number
        i.save

        f = Inventory.find_by(user_id: tb.user_id, badge_id: tb.badge_id)
        f.number ||= 0
        f.number -= tb.number

        if f.number < 1
          f.destroy
        else
          f.save
        end
      end

      self.update(closed: true)
    end
  end
end
