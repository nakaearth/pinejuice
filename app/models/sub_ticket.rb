# frozen_string_literal: true

class SubTicket < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :ticket, dependent: :destroy

  validates :title, presence: true, length: { maximum: 80 }
  validates :description, presence: true, length: { maximum: 1024 }
  validates :point, numericality: { only_integer: true }
end
