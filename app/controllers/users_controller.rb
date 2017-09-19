class UsersController < ApplicationController
  before_action :signed_in?, only: :me

  def me
    @trades = current_user.trades
  end

  def show
    if params[:id]&.to_i == current_user.id
      redirect_to me_path
      return
    end

    @user = User.find(params[:id])
  end

  def login_page
  end

  def login
    user = User.find_by(email: params[:email])
    
    # password is type BCrypt::Password
    if user && user.password == params[:password]
      session[:user_id] = user.id

      flash_messages << {text: "Welcome back!", kind: "notice"}
      redirect_to root_path
    else
      flash_messages << {text: "incorrect email/password combination", kind: "alert"}
      redirect_to :back
    end
  end

  def register_page
  end

  def register
    unless params["password"] == params["password_confirmation"]
      flash_messages << {text: "Password confirmation does not match.", kind: "alert"}
      redirect_to register_page_path
      return
    end

    unless params["password"]&.length >= 6
      flash_messages << {text: "Password must be at least 6 characters long.", kind: "alert"}
      redirect_to register_page_path
      return
    end

    user = User.new(
      email: params["email"],
      username: params["username"],
      name: params["name"],
      address: params["address"],
      password_hash: BCrypt::Password.create(params["password"])
    )

    if user.save
      session[:user_id] = user.id

      flash_messages << {text: "Welcome!", kind: "notice"}
      redirect_to root_path
    else
      user.errors.messages.each do |key, message|
        message.each do |text|
          flash_messages << {text: text, kind: "alert"}
        end
      end

      redirect_to register_page_path
    end
  end

  def logout
    session[:user_id] = nil

    flash_messages << {text: "Successfully signed out", kind: "notice"}
    redirect_to root_path
  end
end
