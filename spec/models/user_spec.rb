# frozen_string_literal: true
require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }

  describe '幾つかのテーブルと関連を持っている' do
    context 'have a relation tro user class' do
      it { expect have_many(:photos) }
      it { expect have_many(:group_members) }
      it { expect have_many(:my_groups) }
    end
  end

  describe '入力チェックをする' do
    context 'nameカラム' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_length_of(:name).is_at_most(60) }
    end

    context 'uidカラム' do
      it { is_expected.to validate_presence_of(:uid) }
    end

    context 'emailカラム' do
      it { is_expected.to validate_length_of(:email).is_at_most(60) }
    end

    context 'providerカラム' do
      it { is_expected.to validate_presence_of(:provider) }
      it { is_expected.to validate_length_of(:provider).is_at_most(30) }
    end
  end
end
