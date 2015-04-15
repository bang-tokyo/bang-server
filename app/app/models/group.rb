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

class Group < ActiveRecord::Base

  enum status: {inactive: 0, active: 1}

  has_many :group_user
  has_many :group_setting

  class << self
    def fetch!()
      raise Bang::Error::AuthenticationFailed.new unless token.present?
      id, secret = token.split(SEPARATOR)
      user = find_by(id: id)
      raise Bang::Error::AuthenticationFailed.new unless user.present?
      raise Bang::Error::AuthenticationFailed.new unless user.secret == secret
      user
    end

    def fetch()
      begin
        fetch!()
      rescue Bang::Error::AuthenticationFailed
        nil
      end
    end
  end

  def gender_value
    self.class.genders[gender]
  end

  def status_value
    self.class.statuses[status]
  end

  def active?
    status == self.class.statuses[:active]
  end

  def banned?
    !active?
  end

  private
  def generate_secret
    return if self.secret.present?
    self.secret = Array.new(64) { SEEDS[rand(SEEDS.size)] }.join
  end

end
