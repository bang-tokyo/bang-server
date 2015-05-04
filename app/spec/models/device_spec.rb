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

require 'rails_helper'

RSpec.describe Device, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
