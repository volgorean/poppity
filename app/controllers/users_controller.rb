class UsersController < ApplicationController
  def me

  end

  def show
    @user = User.find(params[:id])
  end
end
