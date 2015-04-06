class Init < ActiveRecord::Migration
    def change
        create_users
        create_user_activities
        create_user_positions
    end

    private
    def create_users
        create_table :users, id: :bigint, unsigned: true do |t|
            t.string :facebook_id, limit: 128, null: false, dafault: ""
            t.string :name, limit: 191, null: false, dafault: ""
            t.string :birthday, limit: 10, null: false, defalt: ""
            t.integer :gender, limit: 3, null: false, defalt: 3
            t.integer :region_id, limit: 3, null: false, defalt: 0
            t.integer :salary_category_id, limit: 3, null: false, defalt: 0
            t.integer :status, limit: 3, null: false, defalt: 0
            t.integer :billing_status, limit: 3, null: false, defalt: 0
            t.string :encrypted_token, limit: 255, null: false
            t.timestamps null: false
        end
    end

    def create_user_activities
        create_table :user_activities, id: :bigint, unsigned: true do |t|
            t.bigint :user_id, unsigned: true, null: false
            t.timestamps null: false
        end

        add_index :user_activities, :user_id, unique: true
    end

    def create_user_positions
        create_table :user_positions, id: :bigint, unsigned: true do |t|
            t.bigint :user_id, unsigned: true, null: false
            t.decimal :latitude, :precision => 9, :scale => 6, null: false
            t.decimal :longitude, :precision => 9, :scale => 6, null: false
            t.timestamps null: false
        end

        add_index :user_positions, :user_id, unique: true
        add_index :user_positions, [:latitude, :longitude]
    end
end
