class BadgesController < ApplicationController
  def show
    @badge = Badge.find(params[:id])

    @wishers = @badge.wishers.where.not(id: current_user&.id)
    @owners = @badge.users.where.not(id: current_user&.id)
  end
end
