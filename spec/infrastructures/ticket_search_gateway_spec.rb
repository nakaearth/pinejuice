# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TicketSearchGateway, broken: true do
  describe '.call' do
    let(:user) { create(:user) }

    describe 'キーワード指定の検索' do
      context '単純なワード検索の場合' do
        let(:ticket) { create(:ticket, title: '開発チケット', description: 'これは開発タスクのチケットです。¥n開発ようです', point: 5, user: user) }
        let(:ticket2) { create(:ticket, title: 'QAチケット', description: 'これはQAのチケットです。¥n開発ようです', point: 1, user: user) }
        let(:ticket3) do
          create(:ticket, title: '企画チケット', description: 'これは企画関係のチケットです。¥n開発ようです', point: 10, user: user)
        end

        it 'タイトル中のワードで検索ができる' do
          SetupIndexElasticsearchGateway.create_index(override: true)
          ImportTicketToEsGateway.bulk_import(ticket_ids: [ticket.id, ticket2.id, ticket3.id])

          results = TicketSearchGateway.call(user_id: user.id, keyword: 'チケット')
          result_ids = results[:entries].map { |r| r['id'] }
          expect(result_ids.include?(ticket.id)).to eq true
          expect(result_ids.include?(ticket2.id)).to eq true
          expect(result_ids.include?(ticket3.id)).to eq true
        end

        it 'タイトル中の特定のワードで検索ができる' do
          SetupIndexElasticsearchGateway.create_index(override: true)
          ImportTicketToEsGateway.bulk_import(ticket_ids: [ticket.id, ticket2.id, ticket3.id])

          result = TicketSearchGateway.call(user_id: user.id, keyword: '開発タスク')
          expect(result[:entries][0]['id']).to eq ticket.id
        end
      end

      context '辞書に載っていないようなキーワードで検索した場合' do
        let(:ticket) do
          create(:ticket, title: 'ホゲホゲチケット', description: 'これはホゲホゲ開発に関するチケットです。¥n開発ようです', point: 5, user: user)
        end
        let(:ticket2) do
          create(:ticket, title: 'ウガウガQAチケット', description: 'これはQAのチケットです。¥n開発ようです', point: 1, user: user)
        end
        let(:ticket3) do
          create(:ticket, title: '企画フガフガチケット', description: 'これはホゲホゲ企画のフガに関係するチケットです。¥n開発ようです', point: 10, user: user)
        end

        it 'タイトル中のワードで検索ができる' do
          SetupIndexElasticsearchGateway.create_index(override: true)
          ImportTicketToEsGateway.bulk_import(ticket_ids: [ticket.id, ticket2.id, ticket3.id])

          results = TicketSearchGateway.call(user_id: user.id, keyword: 'ウガ')
          result_ids = results[:entries].map { |r| r['id'] }
          expect(result_ids.include?(ticket2.id)).to eq true
        end

        it '本文中に含まれているワードでも検索ができる' do
          SetupIndexElasticsearchGateway.create_index(override: true)
          ImportTicketToEsGateway.bulk_import(ticket_ids: [ticket.id, ticket2.id, ticket3.id])

          results = TicketSearchGateway.call(user_id: user.id, keyword: 'ホゲ')
          result_ids = results[:entries].map { |r| r['id'] }
          expect(result_ids.include?(ticket.id)).to eq true
          expect(result_ids.include?(ticket3.id)).to eq true
        end
      end
    end
  end
end
