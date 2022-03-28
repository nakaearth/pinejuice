# frozen_string_literal: true

class User < ApplicationRecord
  has_many :tickets, dependent: :destroy

  validates :name, presence: true, length: { maximum: 60 }
  validates :uid, presence: true
  validates :email, length: { maximum: 60 }
  validates :provider, presence: true, length: { maximum: 30 }
end
