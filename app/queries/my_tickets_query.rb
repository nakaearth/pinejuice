# frozen_string_literal: true
# frozen_string_literal: truea

class MyTicketsQuery
  class << self
    def search(user_id:, display_count: 50, page: 1)
      # もしpageが1よりも小さい値の場合は強制的に1にする
      page = 1 if page < 1
      Ticket.where(user_id: user_id).limit(display_count)
            .offset((page - 1) * display_count).order('id desc')
    end
  end
end
