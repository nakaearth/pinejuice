# frozen_string_literal: true

FactoryBot.define do
  factory :ticket do
    title { 'テストチケット' }
    description { 'これはテスト用のチケットです' }
    point { 10 }
  end
end
