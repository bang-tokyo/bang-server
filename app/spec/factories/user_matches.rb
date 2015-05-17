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

FactoryGirl.define do
  factory :user_match do

  end

end
