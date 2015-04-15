# == Schema Information
#
# Table name: groups
#
#  id            :integer          not null, primary key
#  owner_user_id :integer          not null
#  name          :string(100)      default(""), not null
#  memo          :text(65535)
#  region_id     :integer          default(0), not null
#  status        :integer          default(0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryGirl.define do
  factory :group do
    
  end

end
