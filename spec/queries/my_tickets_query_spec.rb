# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MyTicketsQuery, ci: true do
  describe '.execute' do
    let(:user) { create(:user, provider: 'twitter', email: 'hoge@gmail.com', name: 'ホゲ太郎') }
    let!(:my_tickets) { create_list(:ticket, 5, user_id: user.id) }

    context '自分のチケットが登録されている場合' do
      it '自分のチケットの一覧が取得できる' do
        tickets = MyTicketsQuery.search(
          user_id: user.id,
          display_count: 3,
          page: 1
        )
        aggregate_failures do
          expect(tickets.size).to eq 3
          expect(tickets[0].id).to eq my_tickets[4].id
        end
      end
    end

    # context 'エラーが発生した場合' do
    #   it '例外をraiseする' do
    #     expect do
    #       RegistTicketUsecase.execute(current_user: user,
    #                                   title: nil,
    #                                   description: '朝の負荷状況を調べて共有します',
    #                                   point: 5)
    #     end.to raise_error(RegistTicketError)
    #   end
    # end
  end
end
