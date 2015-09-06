# == Schema Information
#
# Table name: group_bangs
#
#  id            :integer          not null, primary key
#  group_id      :integer          not null
#  from_group_id :integer          not null
#  item_id       :integer          default(0), not null
#  status        :integer          default(0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe GroupBang, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
