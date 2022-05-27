# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MyTicketsQuery, ci: true do
  describe '.execute' do
    let(:user) { create(:user, provider: 'twitter', email: 'hoge@gmail.com', name: 'ホゲ太郎') }
    let!(:my_tickets) { create_list(:ticket, 5, user_id: user.id) }

    context '自分のチケットが登録されている場合' do
      it '自分のチケットの一覧が取得できる' do
        allow(TicketSearchGateway).to receive(:call).and_return(
          {
             entries: [],
             total_count: 0
          }
        )
        tickets = TicketSearchQuery.search(
          user_id: user.id,
          keyword: 'テスト'
        )
        aggregate_failures do
          expect(tickets[:entries].size).to eq 0
          expect(tickets[:total_count]).to eq 3
        end
      end
    end
  end
end
