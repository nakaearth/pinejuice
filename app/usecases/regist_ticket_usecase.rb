# frozen_string_literal: true

class RegistTicketUsecase
  class << self
    def execute(current_user:, title:, description:, point:)
      ActiveRecord::Base.transaction do
        Ticket.create!(
          title: title,
          description: description,
          point: point,
          user: current_user
        )
      rescue StandardError
        raise RegistTicketError.new('チケット登録に失敗しました。', 'regist_ticket_error')
      end

      # RegistrationTicketForSearchGateway.regist(ticket)
    end
  end
end
