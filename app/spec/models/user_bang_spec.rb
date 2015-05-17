# == Schema Information
#
# Table name: user_bangs
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  from_user_id :integer          not null
#  item_id      :integer          default(0), not null
#  status       :integer          default(0), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe UserBang, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
