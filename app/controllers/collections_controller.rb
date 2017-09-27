class CollectionsController < ApplicationController
  def index
    @collections = Collection.all
  end

  def show
    @collection = Collection.preload(:badges).find(params[:id])
    
    wishes = []
    wishes = current_user.wishes.pluck(:badge_id) if current_user

    @badges = []
    @collection.badges.order('year DESC').group_by(&:year).each do |year, badges|
      @badges << { year: year, badges: []}

      badges.each do |badge|
        @badges.last[:badges] << {
          id: badge.id,
          name: badge.name,
          image: badge_image_path(badge),
          link: badge_path(badge),
          wish: (wishes.include? badge.id)
        }
      end
    end
  end
end
