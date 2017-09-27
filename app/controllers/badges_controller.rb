class BadgesController < ApplicationController
  before_action :signed_in?, except: :show

  def show
    @badge = Badge.find(params[:id])

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
    respond_to do |format|
      format.json { head :ok }
    end
  end
end
