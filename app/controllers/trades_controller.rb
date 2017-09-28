class TradesController < ApplicationController
  before_action :signed_in?

  def show
    # trying to minimize db calls
    @trade = current_user.trades.preload(trade_badges: :badge).find(params[:id])
    @them = @trade.a_id == current_user.id ? @trade.b : @trade.a

    # your offer should display their wish items not yours
    @your_wishes = current_user.wish_items
    @their_wishes = @them.wish_items

    @your_offer = @trade.trade_badges.where(user_id: current_user.id)
    @their_offer = @trade.trade_badges.where(user_id: @them.id)

    if (@trade.a_accepts && @trade.b_accepts)
      @your_badges = Badge.where(id: @your_offer.pluck(:badge_id))
      @their_badges = Badge.where(id: @their_offer.pluck(:badge_id))
    else
      @your_badges = current_user.badges
      @their_badges = @them.badges
    end

    @your_badges = @your_badges.map do |badge|
      {
        id: badge.id,
        name: badge.name,
        inventory: badge.inventories.find_by(user: current_user)&.number,
        trading: (@your_offer.find_by(badge_id: badge.id)&.number || 0),
        wish: @their_wishes.include?(badge),
        image: badge.image.url
      }
    end

    @their_badges = @their_badges.map do |badge|
      {
        id: badge.id,
        name: badge.name,
        inventory: badge.inventories.find_by(user: @them)&.number,
        trading: (@their_offer.find_by(badge_id: badge.id)&.number || 0),
        wish: @your_wishes.include?(badge),
        image: badge.image.url
      }
    end
  end

  def create
    trade = Trade.new(
      a: current_user,
      b: User.find(params[:user_id])
    )

    if trade.save
      redirect_to trade_path(trade)
    else
      flash_messages << {text: "Failed to create trade.", kind: "alert"}
      redirect_back(fallback_location: root_path)
    end
  end
end
