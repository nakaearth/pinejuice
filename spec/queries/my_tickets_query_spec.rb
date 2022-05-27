# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MyTicketsQuery, ci: true do
  describe '.execute' do
    let(:user) { create(:user, provider: 'twitter', email: 'hoge@gmail.com', name: 'ホゲ太郎') }
    let(:another_user) { create(:user, provider: 'twitter', email: 'hoge2@gmail.com', name: 'ふが太郎') }
    let!(:my_tickets) { create_list(:ticket, 5, user_id: user.id) }
    let!(:another_tickets) { create_list(:ticket, 3, user_id: another_user.id) }

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
      
      it '他の人のチケットは取得できない' do
        tickets = MyTicketsQuery.search(
          user_id: user.id,
          display_count: 3,
          page: 1
        )
        expect(tickets.map(&:id).any? { |i| another_tickets.include?(i) }).to eq false
      end
    end
  end
end
