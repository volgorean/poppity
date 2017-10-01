class CollectionsController < ApplicationController
  def index
    @collections = Collection.all
  end

  def show
    @collection = Collection.preload(:badges).friendly.find(params[:id])
    
    wishes = []
    wishes = current_user.wishes.pluck(:badge_id) if current_user

    @badges = []
    @collection.badges.page(params[:page]).per(50).order('year DESC, id ASC').group_by(&:year).each do |year, badges|
      @badges << { year: year, badges: []}

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
