# == Schema Information
#
# Table name: user_positions
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  latitude   :decimal(9, 6)    not null
#  longitude  :decimal(9, 6)    not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserPosition < ActiveRecord::Base
end
