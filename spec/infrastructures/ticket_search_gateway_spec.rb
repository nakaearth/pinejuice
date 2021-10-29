# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TicketSearchGateway do
  describe '.call' do
    let(:user) { create(:user) }
    let(:ticket) { create(:ticket, title: '開発チケット', description: 'これはテストチケットです。¥n開発ようです', point: 5, user: user) }

    describe 'キーワード指定の検索' do
      it 'タイトル中のワードで検索ができる' do
        result = TicketSearchGateway.call(user_id: user.id, keyword: '開発')
        expect(results[:result_records][0].id).to eq ticket.id
      end
    end
#    before do
#      Search::ElasticsearchIndexGateway.create_index('albums')
#    end
#
#    context '1件だけ指定したユーザが作成したアルバムがある場合' do
#      let(:user) { create(:user) }
#      let(:album) do
#        create(:album, title: 'テスト犬album', user: user).tap do |al|
#          create(:photo, description: 'これは犬の写真です',album: al, user: user)
#          create(:tag, label_name: '犬', album: al)
#        end
#      end
#
#      let(:params) { { keyword: '犬' } }
#
#      before do
#        album
#        Search::AlbumToElasticsearchInsertGateway.bulk('albums')
#        @results = Albums::AlbumSearchQuery.call(keyword: params[:keyword], user_id: user.id)
#      end
#
#      it '検索結果と検索結果の総数、アグリゲーションの結果が格納されたHashを返す' do
#        expect(@results.size).to eq 3
#        expect(@results[:result_records].size).to eq 1
#        expect(@results[:aggregations].empty?).to eq false
#      end
#
#      it 'keywordで指定したものが返ってくる' do
#        expect(@results[:result_records][0].id).to eq album.id
#        expect(@results[:result_records][0].title).to eq album.title
#      end
#    end
  end
end
