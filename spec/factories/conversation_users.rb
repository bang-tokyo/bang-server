# == Schema Information
#
# Table name: conversation_users
#
#  id              :integer          not null, primary key
#  conversation_id :integer          not null
#  user_id         :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :conversation_user do

  end

end
