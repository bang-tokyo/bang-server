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

class UserProfileImage < ActiveRecord::Base
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'

  validates :user_id, presence: true, on: :create
  validates :code, presence: true, on: :create

  before_validation :generate_code, on: :create

  def image_s3_key_name
    prefix = Settings[:s3][:profile_image][:key_prefix]
    "#{prefix}profile/#{id.to_s.reverse}-#{code}.jpg"
  end

  def image_path
    timestamp = updated_at.to_i
    bucket = Settings[:s3][:profile_image][:bucket]
    cdn_domain = Settings[:s3][:profile_image][:cdn_domain]
    "https://#{cdn_domain}/#{bucket}/#{image_s3_key_name}?#{timestamp}"
  end

  private
  def generate_code 
    return if self.code.present?
    self.code = Bang::RandomCodeGenerator.generator(10)
  end
end
