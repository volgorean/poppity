require "administrate/base_dashboard"

class TradeDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    a: Field::BelongsTo.with_options(class_name: "User"),
    b: Field::BelongsTo.with_options(class_name: "User"),
    trade_badges: Field::HasMany,
    badges: Field::HasMany,
    id: Field::Number,
    a_id: Field::Number,
    b_id: Field::Number,
    chat: Field::String.with_options(searchable: false),
    a_accepts: Field::Boolean,
    b_accepts: Field::Boolean,
    a_accepts_at: Field::DateTime,
    b_accepts_at: Field::DateTime,
    a_sent: Field::Boolean,
    b_sent: Field::Boolean,
    a_sent_at: Field::DateTime,
    b_sent_at: Field::DateTime,
    a_recieved: Field::Boolean,
    b_recieved: Field::Boolean,
    a_recieved_at: Field::DateTime,
    b_recieved_at: Field::DateTime,
    closed: Field::Boolean,
    last_change_at: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :a,
    :b,
    :trade_badges,
    :badges,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :a,
    :b,
    :trade_badges,
    :badges,
    :id,
    :a_id,
    :b_id,
    :chat,
    :a_accepts,
    :b_accepts,
    :a_accepts_at,
    :b_accepts_at,
    :a_sent,
    :b_sent,
    :a_sent_at,
    :b_sent_at,
    :a_recieved,
    :b_recieved,
    :a_recieved_at,
    :b_recieved_at,
    :closed,
    :last_change_at,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :a,
    :b,
    :trade_badges,
    :badges,
    :a_id,
    :b_id,
    :chat,
    :a_accepts,
    :b_accepts,
    :a_accepts_at,
    :b_accepts_at,
    :a_sent,
    :b_sent,
    :a_sent_at,
    :b_sent_at,
    :a_recieved,
    :b_recieved,
    :a_recieved_at,
    :b_recieved_at,
    :closed,
    :last_change_at,
  ].freeze

  # Overwrite this method to customize how trades are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(trade)
  #   "Trade ##{trade.id}"
  # end
end
