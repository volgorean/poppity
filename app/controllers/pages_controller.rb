class PagesController < ApplicationController
  def show
    if  File.exist?(Pathname.new(Rails.root + "app/views/pages/#{params[:page]}.html.erb"))
      render template: "pages/#{params[:page]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end
end
