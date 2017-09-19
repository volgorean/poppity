class TradesController < ApplicationController
  # must be signed in

  def show
    @trade = current_user.trades.find(params[:id])
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
  end
end
