class ApplicationController < ActionController::Base
  include ApplicationHelper

  protect_from_forgery with: :exception

  private

  def signed_in?
    unless current_user
      flash_messages << {text: "Must be signed in to preform this action.", kind: "alert"}
      redirect_to login_page_path
    end
  end
end
