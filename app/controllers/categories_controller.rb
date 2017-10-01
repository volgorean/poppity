class CategoriesController < ApplicationController
  def show
    @category = Category.preload(:badges).friendly.find(params[:id])
    
    wishes = []
    wishes = current_user.wishes.pluck(:badge_id) if current_user

    @badges = []
    @category.badges.page(params[:page]).per(50).order(:id).group_by(&:collection).each do |collection, badges|
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
