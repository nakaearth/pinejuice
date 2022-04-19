# frozen_string_literal: true

FactoryBot.define do
  factory :ticket do
    sequence(:title) { |n| "テスト#{n}番目のチケット" }
    sequence(:description) { |n| "これは#{n}番目のテスト用のチケットです" }
    point { 10 }
  end
end
