# == Schema Information
#
# Table name: user_activities
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserActivity < ActiveRecord::Base
end
