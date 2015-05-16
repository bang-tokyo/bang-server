# == Schema Information
#
# Table name: group_settings
#
#  id         :integer          not null, primary key
#  group_id   :integer          not null
#  key        :integer          default(0), not null
#  value      :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe GroupSetting, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
