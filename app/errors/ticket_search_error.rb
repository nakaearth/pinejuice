# frozen_string_literal: true

class TicketSearchError < StandardError
  attr_reader :error_type

  def initialize(message, error_type)
    super(message)
    @error_type = error_type
  end
end
