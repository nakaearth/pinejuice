# frozen_string_literal: true

module Api
  class TicketsController < ActionController::API
    def index
      form = TicketsForm.new(params)
      @tickets = MyTicketsQuery.search(user_id: form.user_id, display_count: 50, page: 1)
    end

    def search
      form = TicketsSearchForm.new(params)
      @tickets = TicketSearchQuery.search(user_id: form.user_id, keyword: form.keyword)
    end
  end
end