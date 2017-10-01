class BadgesController < ApplicationController
  before_action :signed_in?, except: [:show, :image]

  def show
    @badge = Badge.preload(:wishers, :users, :collection).friendly.find(params[:id])
    @inventory = @badge.inventories.find_by(user: current_user)&.number || 0

    @wishers = @badge.wishers
    @owners = @badge.users.preload(:inventories)
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

  def search
    wishes = []
    wishes = current_user.wishes.pluck(:badge_id) if current_user

    @badges = []
    Badge.where("name ~* ?", params[:search]).page(params[:page]).per(50).order(:id).group_by(&:collection).each do |collection, badges|
      @badges << { collection: collection.name, badges: []}

      badges.each do |badge|
        @badges.last[:badges] << {
          id: badge.id,
          name: badge.name,
          image: badge.image.url,
          link: badge_path(badge),
          wish: (wishes.include? badge.id)
        }
      end
    end

    respond_to do |format|
      format.html
      format.json { render json: @badges }
    end
  end
end
