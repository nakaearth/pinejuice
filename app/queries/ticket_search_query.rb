# frozen_string_literal: true

class TicketSearchQuery
  class << self
    def search(user_id:, keyword:)
      # もしpageが1よりも小さい値の場合は強制的に1にする
      tickets = TicketSearchGateway.search(user_id: user_id, keyword: keyword)

      tickets.map do |ticket|
        { 
            id: ticket.id,
            title: ticket.title,
            
        }
      end
    end
  end
end
