# == Schema Information
#
# Table name: conversations
#
#  id         :integer          not null, primary key
#  kind       :integer          default(0), not null
#  status     :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Conversation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
