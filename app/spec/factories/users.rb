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

FactoryGirl.define do
  factory :user do
    sequence(:id, 100) { |n| n }
    name { "user_#{id}" }
    birthday { "1983/10/04" }
    gender :male
    region_id { 1 }
    salary_category_id { 1 }
    status :active
    secret 'QEVuQwBAEABBnbCPvCuT4K1l3UTbixrd1'
  end
end
