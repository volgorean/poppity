class TradeChannel < ApplicationCable::Channel
  def subscribed
    @trade = current_user.trades.find(params[:id])
    stream_from "trade_#{@trade.id}"
  end

  def unsubscribed

  end

  def update_status(stat)
    @trade.reload
    return if @trade.closed

    status = stat["status"]
    value = stat["value"]
    who = @trade.a_id == current_user.id ? "a" : "b"

    case status
    when "accepts"
      @trade.update("#{who}_accepts" => value, "#{who}_accepts_at" => (value ? Time.now : nil)) unless @trade.a_accepts && @trade.b_accepts
    when "sent"
      @trade.update("#{who}_sent" => true, "#{who}_sent_at" => Time.now) unless @trade.send("#{who}_sent")
    when "recieved"
      @trade.update("#{who}_recieved" => true, "#{who}_recieved_at" => Time.now) unless @trade.send("#{who}_recieved")
    when "closed"
      @trade.update(closed: true) unless @trade.a_accepts && @trade.b_accepts
    end

    ActionCable.server.broadcast("trade_#{@trade.id}", {
      kind: "update_status",
      accepts: {
        a: @trade.a_accepts,
        a_at: @trade.a_accepts_at.to_i,
        b: @trade.b_accepts,
        b_at: @trade.b_accepts_at.to_i
      },
      sent: {
        a: @trade.a_sent,
        a_at: @trade.a_sent_at.to_i,
        b: @trade.b_sent,
        b_at: @trade.b_sent_at.to_i
      },
      recieved: {
        a: @trade.a_recieved,
        a_at: @trade.a_recieved_at.to_i,
        b: @trade.b_recieved,
        b_at: @trade.b_recieved_at.to_i
      },
      closed: @trade.closed
    })

    ActionCable.server.broadcast("trade_#{@trade.id}", {
      kind: "update_status",
      send_to: {
        name: @trade.send(who).name,
        address: @trade.send(who).address
      }
    }) if @trade.a_accepts && @trade.b_accepts
  end

  def update_offer(item)
    @trade.reload
    return if @trade.closed
    return if @trade.a_accepts && @trade.b_accepts

    if item["trading"] > 0
      item["trading"] = [(Inventory.find_by(user_id: item["user"], badge_id: item["badge"])&.number || 0), item["trading"]].min

      tb = @trade.trade_badges.find_or_initialize_by(user_id: item["user"], badge_id: item["badge"])
      tb.number = item["trading"]
      return unless tb.save
    else
      @trade.trade_badges.find_by(user_id: item["user"], badge_id: item["badge"])&.destroy
    end

    if @trade.update(a_accepts: false, a_accepts_at: nil, b_accepts: false, b_accepts_at: nil, last_change_at: Time.now)
      ActionCable.server.broadcast("trade_#{@trade.id}", {
        kind: "update_status",
        accepts: {
          a: @trade.a_accepts,
          a_at: @trade.a_accepts_at.to_i,
          b: @trade.b_accepts,
          b_at: @trade.b_accepts_at.to_i
        }
      })

      ActionCable.server.broadcast("trade_#{@trade.id}", {kind: "update_offer", user: item["user"], badge: item["badge"], trading: item["trading"]})
    end
  end
end