class TradeChannel < ApplicationCable::Channel
  def subscribed
    @trade = current_user.trades.find(params[:id])
    stream_from "trade_#{@trade.id}"
  end

  def unsubscribed

  end

  def update_status(status)
    ActionCable.server.broadcast("trade_#{trade.id}", {ha: data["message"]})
  end

  def update_offer(item)
    if item["trading"] == true
      @trade.trade_badges.find_or_create_by(user_id: item["user"], badge_id: item["badge"])
    else
      @trade.trade_badges.find_by(user_id: item["user"], badge_id: item["badge"])&.destroy
    end

    ActionCable.server.broadcast("trade_#{@trade.id}", {kind: "update_offer", user: item["user"], badge: item["badge"], trading: item["trading"]})
  end
end