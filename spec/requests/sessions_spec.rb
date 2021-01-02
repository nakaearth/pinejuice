# frozen_string_literal: true

require 'rails_helper'

describe 'Sessions', type: :request do
  let(:user) { create(:user) }
  let(:now) { Time.zone.strptime('2021-01-01', '%F') }

  around do |e|
    travel_to(now) { e.run }
  end

  describe '#create' do
    context '新規登録でログイン先から返却値に正しく値が入っている場合' do
      it 'ユーザが登録される' do
      end
    end

    context '既に登録されているユーザでログインした時にログイン先から正しく値が返ってくる場合' do
      it '既に登録されているユーザの情報が返る' do
      end
    end

    context 'ログイン処理でログイン先から正しい値が返ってこなかった場合' do
      it '例外がraiseされる' do
      end
    end
  end
end