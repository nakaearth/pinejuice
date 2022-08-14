# frozen_string_literal: true

module Api
  class TicketsController < ApplicationController
    def index
      form = TicketsForm.new(params)
      @tickets = MyTicketsQuery.search(user_id: form.user_id, display_count: 50, page: 1)
    end

    def search
      form = TicketSearchForm.new(params)
      @tickets = TicketSearchQuery.search(user_id: form.user_id, keyword: form.keyword)
      render json: @tickets
    end
  end
end