class Init < ActiveRecord::Migration
    def change
        create_users
        create_user_activities
        create_user_positions

        create_groups
    end

    private
    def create_users
        create_table :users, id: :bigint, unsigned: true do |t|
            t.string :facebook_id, limit: 128, null: false, default: ""
            t.string :name, limit: 191, null: false, default: ""
            t.string :birthday, limit: 10, null: false, default: ""
            t.integer :gender, limit: 3, null: false, default: 3
            t.integer :region_id, limit: 3, null: false, default: 0
            t.integer :salary_category_id, limit: 3, null: false, default: 0
            t.integer :status, limit: 3, null: false, default: 0
            t.string :encrypted_secret, limit: 255, null: false
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

    def create_groups
        create_table :groups, id: :bigint, unsigned: true do |t|
            t.string :owner_user_id :bigint, null: false, default: ""
            t.string :name, limit: 100, null: false, default: ""
            t.string :memo, limit: 1000, default: ""
            t.integer :region_id, limit: 1000, null: false, default: 0
            t.integer :status, limit: 3, null: false, default: 0
            t.timestamps null: false
        end
    end
end
