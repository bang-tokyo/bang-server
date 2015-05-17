# == Schema Information
#
# Table name: user_matches
#
#  id         :integer          not null, primary key
#  match_id   :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe UserMatch, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
