class CreateModels < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :password_hash

      t.boolean :admin, default: false
      t.boolean :verified, default: false
      t.boolean :banned, default: false

      t.string :name
      t.string :address

      t.timestamps
    end

    create_table :collections do |t|
      t.string :name
      t.has_attached_file :image
      t.integer :badges_count, default: 0
    end

    create_table :categories do |t|
      t.string :name
      t.has_attached_file :image
      t.integer :badges_count, default: 0
    end

    create_table :badges do |t|
      t.string :name
      t.string :year

      t.has_attached_file :image

      t.integer :category_id
      t.integer :collection_id

      t.timestamps
    end

    create_table :inventories do |t|
      t.integer :number

      t.integer :user_id
      t.integer :badge_id

      t.timestamps
    end

    create_table :wishes do |t|
      t.integer :user_id
      t.integer :badge_id

      t.timestamps
    end

    create_table :trades do |t|
      t.integer :a_id
      t.integer :b_id

      t.jsonb :chat

      t.boolean :a_accepts, default: false
      t.boolean :b_accepts, default: false

      t.datetime :a_accepts_at
      t.datetime :b_accepts_at

      t.boolean :a_sent, default: false
      t.boolean :b_sent, default: false

      t.datetime :a_sent_at
      t.datetime :b_sent_at

      t.boolean :a_recieved, default: false
      t.boolean :b_recieved, default: false

      t.datetime :a_recieved_at
      t.datetime :b_recieved_at

      t.boolean :closed, default: false
      t.datetime :last_change_at

      t.timestamps
    end

    create_table :trade_badges do |t|
      t.integer :number

      t.integer :trade_id
      t.integer :badge_id
      t.integer :user_id

      t.timestamps
    end

  end
end
