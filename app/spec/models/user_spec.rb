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

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '::fetch_by_token' do
    subject { User.fetch_by_token!(token) }
    before do
      @user = create(:user)
    end

    context 'When the token is collect' do
      let(:token) { "#{@user.id}-#{@user.secret}" }
      it { is_expected.to be_instance_of User }
      it { expect( subject.id ).to eq @user.id }
    end

    context 'When the token is not collect' do
      let(:token) { "#{@user.id}-xxxxxxxx" }
      it { expect{ subject }.to raise_error Bang::Error::AuthenticationFaild }
    end
  end

  describe '#gender_value' do
    subject { user.gender_value }
    let(:user) { create(:user, gender: gender) }

    context 'When its gender is male' do
      let(:gender) { :male }
      it { is_expected.to eq 1 }
    end

    context 'When its gender is female' do
      let(:gender) { :female }
      it { is_expected.to eq 2 }
    end

    context 'When its gender is transgender' do
      let(:gender) { :transgender }
      it { is_expected.to eq 3 }
    end
  end

  describe '#status_value' do
    subject { user.status_value }
    let(:user) { create(:user, status: status) }

    context 'When its status is active' do
      let(:status) { :active }
      it { is_expected.to eq 1 }
    end

    context 'When its status is banned' do
      let(:status) { :banned }
      it { is_expected.to eq 2 }
    end
  end
end
