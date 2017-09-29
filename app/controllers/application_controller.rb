class ApplicationController < ActionController::Base
  include ApplicationHelper

  protect_from_forgery with: :exception

  private

  def signed_in?
    if !current_user
      flash_messages << {text: "Must be signed in to perform this action.", kind: "alert"}
      redirect_to login_page_path
    elsif current_user.banned
      session[:user_id] = nil

      flash_messages << {text: "This account has been suspended.", kind: "alert"}
      redirect_to login_page_path
    end
  end
end
