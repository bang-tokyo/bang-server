# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  facebook_id        :string(128)      default(""), not null
#  name               :string(191)      default(""), not null
#  birthday           :string(10)       default(""), not null
#  gender             :integer          default(3), not null
#  region_id          :integer          default(0), not null
#  salary_category_id :integer          default(0), not null
#  status             :integer          default(0), not null
#  encrypted_secret   :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class User < ActiveRecord::Base
  SEEDS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze
  SEPARATOR = '-'

  enum gender: {male: 1, female: 2, transgender: 3}
  enum status: {active: 0, banned: 1}

  #has_one :user_activity
  #has_one :user_position

  attr_encrypted :secret, random_iv: true

  validates :secret,
    presence: true,
    on: :create

  before_validation :generate_secret, on: :create

  class << self
    def fetch_by_token!(token)
      raise Bang::Error::AuthenticationFailed.new unless token.present?
      id, secret = token.split(SEPARATOR)
      user = find_by(id: id)
      raise Bang::Error::AuthenticationFailed.new unless user.present?
      raise Bang::Error::AuthenticationFailed.new unless user.secret == secret
      user
    end

    def fetch_by_token(token)
      begin
        fetch_by_token!(token)
      rescue Bang::Error::AuthenticationFailed
        nil
      end
    end
  end

  def token
    "#{self.id}#{SEPARATOR}#{self.secret}"
  end

  def gender_value
    self.class.genders[gender]
  end

  def status_value
    self.class.statuses[status]
  end

  def active?
    status_value == self.class.statuses[:active]
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
