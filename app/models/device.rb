# == Schema Information
#
# Table name: devices
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  status           :integer          default(0), not null
#  uuid             :string(100)      default(""), not null
#  os               :string(16)       default(""), not null
#  os_version       :string(16)       default(""), not null
#  model            :string(255)      default(""), not null
#  app_version      :string(255)      default(""), not null
#  app_version_code :integer          default(0), not null
#  app_id           :string(100)      default(""), not null
#  push_token       :string(4096)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Device < ActiveRecord::Base
  enum status: {inactive: 0, active: 1}

  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'

  validates :user_id,
    presence: true,
    on: :create

  validates :uuid,
    presence: true,
    on: :create

  def fill_from_header(header)
    self.uuid = header.uuid
    self.os = header.os
    self.os_version = header.os_version
    self.model = header.model
    self.app_id = header.app_id
    self.app_version = header.app_version
    self.app_version_code = header.app_version_code
  end
end
