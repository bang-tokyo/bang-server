# == Schema Information
#
# Table name: matches
#
#  id         :integer          not null, primary key
#  type       :integer          default(0), not null
#  status     :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Match < ActiveRecord::Base
end
