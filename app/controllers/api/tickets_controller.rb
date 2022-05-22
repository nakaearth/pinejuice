# frozen_string_literal: true

module Api
  class TicketsController < ActionController::API
    def index
      form = TicketsForm.new(params)
      @tickets = MyTicketsQuery.search(user_id: form.user_id, display_count: 50, page: 1)
    end
  end
end