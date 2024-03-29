# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserRegistration::TwitterUserUsecase, ci: true do
  describe '.call' do
    context 'paramsの値をusersテーブルに登録する値が渡って来た場合' do
      let(:params) do
        {
          provider: 'twitter',
          uid: '12345667',
          email: 'test@gamil',
          name: 'テスト太郎',
          nickname: 'jbloggs',
          image_url: 'http://graph.facebook.com/1234567/picture?type=square',
          credentials: {
            token: 'ABCDEF...', # OAuth 2.0 access_token, which you may wish to store
            secret: '123ABCDEF...' # OAuth 2.0 access_token, which you may wish to store
          }
        }
      end

      it 'パラメータで渡された値でUser登録される' do
        user = UserRegistration::TwitterUserUsecase.execute(
          email: params[:email],
          name: params[:name],
          uid: params[:uid],
          nickname: params[:nickname],
          image_url: params[:image_url],
          credentials: { token: params[:credentials][:token],
                         secret: params[:credentials][:secret] }
        )

        expect(user.provider).to eq params[:provider]
        expect(user.name).to eq params[:name]
        expect(user.email).to eq params[:email]
        expect(user.image_url).to eq params[:image_url]
        expect(user.nickname).to eq params[:nickname]
        expect(user.access_token).to eq params[:credentials][:token]
        expect(user.secret_token).to eq params[:credentials][:secret]
      end
    end

    context '不正なパラメータ(emailがない、uidが空)が渡って来た場合' do
      let(:params) do
        {
          provider: 'twitter',
          uid: '',
          name: 'テスト太郎',
          nickname: 'jbloggs',
          image_url: 'http://graph.facebook.com/1234567/picture?type=square',
          credentials: {
            token: 'ABCDEF...', # OAuth 2.0 access_token, which you may wish to store
            secret: '123ABCDEF...' # OAuth 2.0 access_token, which you may wish to store
          }
        }
      end

      it '例外を出力する' do
        expect do
          UserRegistration::TwitterUserUsecase.execute(
            email: params[:email],
            name: params[:name],
            uid: params[:uid],
            nickname: params[:nickname],
            image_url: params[:image_url],
            credentials: { token: params[:credentials][:token],
                           secret: params[:credentials][:secret] }
          )
        end.to raise_error(UserRegistrationError, 'Twitterのユーザ登録に失敗しました。')
      end
    end
  end
end
