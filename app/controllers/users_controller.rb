class UsersController < ApplicationController
  before_action :signed_in?, only: [:me, :update]

  def me
    @trades = current_user.trades
  end

  def show
    if params[:id].to_i == current_user&.id
      redirect_to me_path
      return
    end

    @user = User.preload(inventories: :badge).friendly.find(params[:id])
    @trades = @user.trades.where("a_id = ? OR b_id = ?", current_user.id, current_user.id).order("created_at DESC") if current_user
    @wishes = @user.wish_items.group_by(&:collection)
    @inventory = @user.badges.preload(:inventories).group_by(&:collection)
  end

  def login_page
    if current_user
      flash_messages << {text: "already signed in.", kind: "alert"}
      redirect_to "/me"
    end
  end

  def login
    user = User.find_by(email: params[:email])
    
    # password is type BCrypt::Password
    if user && user.password == params[:password] && !user.banned
      session[:user_id] = user.id

      flash_messages << {text: "Welcome back!", kind: "notice"}
      redirect_to root_path
    elsif user && user.password == params[:password] && user.banned
      flash_messages << {text: "This account has been suspended.", kind: "alert"}
      redirect_to login_path
    else
      flash_messages << {text: "incorrect email/password combination", kind: "alert"}
      redirect_to login_path
    end
  end

  def register_page
    if current_user
      flash_messages << {text: "already signed in.", kind: "alert"}
      redirect_to "/me"
    end
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

  def update
    unless current_user.password == params[:password]
      flash_messages << {text: "Incorrect password.", kind: "alert"}
      redirect_to me_path
      return
    end

    current_user.name = params["name"]
    current_user.address = params["address"]

    if params["new_password"]&.present?
      unless params["new_password"] == params["new_password_confirmation"]
        flash_messages << {text: "Password confirmation does not match.", kind: "alert"}
        redirect_to me_path
        return
      end

      unless params["new_password"]&.length >= 6
        flash_messages << {text: "Password must be at least 6 characters long.", kind: "alert"}
        redirect_to me_path
        return
      end

      current_user.password_hash = BCrypt::Password.create(params["new_password"])
    end

    if current_user.save
      flash_messages << {text: "Account details updated.", kind: "notice"}
      redirect_to me_path
    else
      current_user.errors.messages.each do |key, message|
        message.each do |text|
          flash_messages << {text: text, kind: "alert"}
        end
      end

      redirect_to me_path
    end
  end

  def logout
    session[:user_id] = nil

    flash_messages << {text: "Successfully signed out", kind: "notice"}
    redirect_to root_path
  end
end
