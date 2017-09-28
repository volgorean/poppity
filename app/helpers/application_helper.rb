module ApplicationHelper
  attr_accessor :current_user, :flash_messages

  def current_user
    return nil unless session[:user_id]
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def flash_messages
    @flash_messages ||= FlashCollection.new(session)
  end

  def card_image(path, image_url)
    link_to "", path, class: "card-image", style: "background: url(#{image_url}) no-repeat center; background-size: contain;"
  end

  def drop_icon(path, image_url)
    link_to "", path, class: "flexi-i drop-icon", style: "background: url(#{image_url}) no-repeat center; background-size: contain;"
  end

  class FlashCollection
    include Enumerable

    def initialize(session)
      @session = session
      @messages = JSON.parse(session[:flash_messages], symbolize_names: true) rescue []
    end

    def << (value)
      @messages << value
      @session[:flash_messages] = JSON.generate(@messages)
      @messages
    end

    def each(&block)
      @messages.each(&block)
      @messages = []
      @session[:flash_messages] = nil
    end
  end
end
