# frozen_string_literal: true

require 'rails_helper'

describe 'Sessions', type: :request do
  let(:user) { create(:user) }
  let(:now) { Time.zone.strptime('2021-01-01', '%F') }

  around do |e|
    travel_to(now) { e.run }
  end

  before do
    allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({
      encrypted_user_id: Base64.encode64(user.id.to_s)
    })
  end

  describe '#create' do
    context '新規登録でログイン先から返却値に正しく値が入っている場合' do
      let(:params) do
        {
          'omniauth.auth' => {
             provider: 'twitter',
             uid: '12345667',
             info: {
               email: 'test@gamil',
               name: 'テスト太郎',
               nickname: 'jbloggs',
               image: 'http://graph.facebook.com/1234567/picture?type=square'
             },
             credentials: {
               token: 'ABCDEF...',
               secret: '123ABCDEF...'
             }
          }
        }
      end

      it 'ユーザが登録される' do
        get '/auth/twitter/callback', params: params

        result = JSON.parse(response.body, { :symbolize_names => true })
        expect(result['name']).to eq 'テスト太郎'
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
