# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  match_id   :integer          not null
#  user_id    :integer          not null
#  message    :string(191)      default(""), not null
#  status     :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :message do

  end

end
