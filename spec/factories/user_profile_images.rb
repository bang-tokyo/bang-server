# == Schema Information
#
# Table name: user_profile_images
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  code       :string(10)       not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :user_profile_image do
    
  end

end
