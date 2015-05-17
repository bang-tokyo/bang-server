# == Schema Information
#
# Table name: matches
#
#  id         :integer          not null, primary key
#  type       :integer          default(0), not null
#  status     :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Match, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
