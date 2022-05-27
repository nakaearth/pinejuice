# frozen_string_literal: true

class TicketSearchForm
  include ActiveModel::Model

  attr_reader :user_id_raw, :keyword

  validates :user_id_raw, presence: true, numericality: true
  validates :keyword, length: { maximum: 20 }

  def initialize(request_parameters)
    @user_id_raw = request_parameters[:user_id]
    @keyword = request_parameters[:keyword]

    raise TicketSearchError.new(errors.full_messages, 'validation_failed') if invalid?
  end

  def user_id
    @user_id_raw.to_i
  end
end
