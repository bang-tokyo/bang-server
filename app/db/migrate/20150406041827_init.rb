class Init < ActiveRecord::Migration

  def change
    create_users
    create_user_attributes
    create_user_locations
    create_devices
    create_groups
    create_group_users
    create_group_settings
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

  def create_user_attributes
    create_table :user_attributes, id: :bigint, unsigned: true do |t|
      t.bigint :user_id, unsigned: true, null: false
      t.string :key, limit: 50, null: false, default: ""
      t.text :value
      t.timestamps null: false
    end

    add_index :user_attributes, [:user_id, :key], unique: true
    add_index :user_attributes, :key
  end

  def create_user_locations
    create_table :user_locations, id: :bigint, unsigned: true do |t|
      t.bigint :user_id, unsigned: true, null: false
      t.decimal :latitude, :precision => 9, :scale => 6, null: false
      t.decimal :longitude, :precision => 9, :scale => 6, null: false
      t.timestamps null: false
    end

    add_index :user_locations, :user_id, unique: true
    add_index :user_locations, [:latitude, :longitude, :updated_at]
  end

  def create_devices
    create_table :devices, id: :bigint, unsigned: true do |t|
      t.bigint :user_id, unsigned: true, null: false
      t.integer :status, limit: 3, null: false, default: 0
      t.string :uuid, limit: 100, null: false, default: ""
      t.string :os, limit: 16, null: false, default: ""
      t.string :os_version, limit: 16, null: false, default: ""
      t.string :model, null: false, default: ""
      t.string :app_version, null: false, default: ""
      t.integer :app_version_code, unsigned: true, null: false, default: 0
      t.string :app_id, limit: 100, null: false, default: ""
      t.string :push_token, limit: 4096
      t.timestamps null: false
    end

    add_index :devices, [:user_id, :os, :uuid, :app_id], unique: true
    add_index :devices, [:user_id, :status]
  end

  def create_groups
      create_table :groups, id: :bigint, unsigned: true do |t|
          t.bigint :owner_user_id, unsigned: true, null: false
          t.string :name, limit: 100, null: false, default: ""
          t.text   :memo
          t.integer :region_id, limit: 3, null: false, default: 0
          t.integer :status, limit: 2, null: false, default: 0
          t.timestamps null: false
      end
  end

  def create_group_users
      create_table :group_users, id: :bigint, unsigned: true do |t|
          t.bigint :group_id, unsigned: true, null: false
          t.bigint :user_id, unsigned: true, null: false
          t.integer :status, limit: 3, null: false, default: 0
          t.timestamps null: false
      end
  end

  def create_group_settings
      create_table :group_settings, id: :bigint, unsigned: true do |t|
          t.bigint :group_id, unsigned: true, null: false
          t.integer :key, limit: 3, null: false, default: 0
          t.integer :value, limit: 3, null: false, default: 0
          t.timestamps null: false
      end
  end

end
