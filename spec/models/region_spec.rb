# == Schema Information
#
# Table name: regions
#
#  id     :integer          not null, primary key
#  name   :string(100)      default(""), not null
#  status :integer          default(1), not null
#

require 'rails_helper'

RSpec.describe Region, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
