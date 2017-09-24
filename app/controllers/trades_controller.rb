class TradesController < ApplicationController
  before_action :signed_in?

  def show
    # trying to minimize db calls
    @trade = current_user.trades.preload(trade_badges: :badge).find(params[:id])
    @them = @trade.a_id == current_user.id ? @trade.b : @trade.a

    # your offer should display their wish items not yours
    @your_wishes = current_user.wish_items
    @their_wishes = @them.wish_items

    @your_offer = @trade.trade_badges.where(user_id: current_user).pluck(:badge_id)
    @their_offer = @trade.trade_badges.where(user_id: @them).pluck(:badge_id)


    @your_badges = current_user.badges.map do |badge|
      {
        id: badge.id,
        name: badge.name,
        trading: @your_offer.include?(badge.id),
        wish: @their_wishes.include?(badge)
      }
    end

    @their_badges = @them.badges.map do |badge|
      {
        id: badge.id,
        name: badge.name,
        trading: @their_offer.include?(badge.id),
        wish: @your_wishes.include?(badge)
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
      puts trade.errors.full_messages
      flash_messages << {text: "Failed to create trade.", kind: "alert"}
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @trade = current_user.trades.find(params[:id])

    # TradeUpdatesChannel.broadcast_to(@post, @comment)
  end
end
