# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'テスト太郎' }
    email { 'test@gmail.com' }
    provider { 'test_provider' }
    nickname { 'ほげking' }
    uid { Base64.encode64('aabbccdd123') }
    access_token { '12345aabc' }
    secret_token { '09876zxy' }
  end
end
