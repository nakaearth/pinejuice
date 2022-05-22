# frozen_string_literal: true

class TicketsForm
  include ActiveModel::Model

  attr_reader :user_id_raw

  validates :user_id_raw, presence: true, numericality: true

  def initialize(request_parameters)
    @user_id_raw = request_parameters[:user_id]

    raise TicketSearchError.new(errors.full_messages, 'validation_failed') if invalid?
  end

  def user_id
    @user_id_raw.to_i
  end
end
