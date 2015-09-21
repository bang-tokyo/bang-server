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

FactoryGirl.define do
  factory :group_bang do
    
  end

end
