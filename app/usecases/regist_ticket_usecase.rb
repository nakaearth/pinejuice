# frozen_string_literal: true

class RegistTicketUsecase
  class << self
    def execute(user: current_user, title:, description:, point:)
      ActiveRecord::Base.transaction do
        Ticket.create!(
          title: title,
          description: description,
          point: point,
          user: current_user
        )
      rescue
        raise RegistTicketError.new('チケット登録に失敗しました。', 'regist_ticket_error')
      end
    end
  end
end
