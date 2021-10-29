# frozen_string_literal: true

class Ticket < ApplicationRecord
  belongs_to :user, dependent: :destroy

  validates :title, presence: true, length: { maximum: 80 }
  validates :description, presence: true, length: { maximum: 1024 }
  validates :point, numericality: { only_integer: true }
end
