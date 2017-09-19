class CreateModels < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :password_hash

      t.boolean :admin

      t.string :name
      t.string :address

      t.timestamps
    end

    create_table :collections do |t|
      t.string :name
      t.string :image
    end

    create_table :categories do |t|
      t.string :name
    end

    create_table :badges do |t|
      t.string :name
      t.integer :year

      t.string :image

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
      t.integer :a
      t.integer :b

      t.jsonb :chat

      t.boolean :a_accepts
      t.boolean :b_accepts

      t.integer :a_accepts_at
      t.integer :b_accepts_at

      t.integer :last_change

      t.timestamps
    end

    create_table :trade_badges do |t|
      t.integer :number

      t.integer :trade_id
      t.integer :inventory_id

      t.timestamps
    end

  end
end
