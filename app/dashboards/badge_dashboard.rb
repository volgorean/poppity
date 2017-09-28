require "administrate/base_dashboard"

class BadgeDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    category: Field::BelongsTo,
    collection: Field::BelongsTo,
    inventories: Field::HasMany,
    users: Field::HasMany,
    wishes: Field::HasMany,
    wishers: Field::HasMany.with_options(class_name: "User"),
    trade_badges: Field::HasMany,
    trades: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    year: Field::String,
    image: Field::String.with_options(searchable: false),
    image_type: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :name,
    :collection,
    :category,
    :users,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :name,
    :year,
    :collection,
    :category,
    :inventories,
    :users,
    :wishes,
    :wishers,
    :trade_badges,
    :trades,
    :image,
    :image_type,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :name,
    :year,
    :category,
    :collection,
    :image,
    :image_type,
  ].freeze

  # Overwrite this method to customize how badges are displayed
  # across all pages of the admin dashboard.

  def display_resource(badge)
    badge.name
  end
end
