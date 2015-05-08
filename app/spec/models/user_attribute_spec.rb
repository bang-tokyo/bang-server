# == Schema Information
#
# Table name: user_attributes
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  key        :string(50)       default(""), not null
#  value      :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe UserAttribute, type: :model do
end
