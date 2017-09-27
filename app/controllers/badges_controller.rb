class BadgesController < ApplicationController
  before_action :signed_in?, except: :show

  def show
    @badge = Badge.find(params[:id])
    @inventory = @badge.inventories.find_by(user: current_user)&.number || 0

    @wishers = @badge.wishers.where.not(id: current_user&.id)
    @owners = @badge.users.where.not(id: current_user&.id)
  end

  def wish
    current_user.wishes.find_or_create_by(badge_id: params[:id])

    respond_to do |format|
      format.json { head :ok }
    end
  end

  def unwish
    current_user.wishes.find_by(badge_id: params[:id])&.destroy

    respond_to do |format|
      format.json { head :ok }
    end
  end

  def inventory
    if params[:number].to_i > 0
      current_user.inventories.find_or_create_by(badge_id: params["id"]).update(number: params[:number])
    elsif params[:number].to_i == 0
      current_user.inventories.find_by(badge_id: params["id"])&.destroy
    end

    respond_to do |format|
      format.json { head :ok }
    end
  end
end
