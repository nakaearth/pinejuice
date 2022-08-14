require 'rails_helper'

describe 'Sessions', type: :request, ci: true do
  let(:current_user) { create(:user) }
  let(:now) { Time.zone.strptime('2021-01-01', '%F') }

  around do |e|
    travel_to(now) { e.run }
  end

  let(:rspec_session) do 
    {
      encrypted_user_id: Base64.encode64(current_user.id.to_s)
    }
  end

  describe '#search' do
    context '正しく検索キーワードを入力した場合' do
      let(:ticket1) { create(:ticket, title: '開発チケット', description: 'これは開発タスクのチケットです。¥n開発ようです', point: 5, user: current_user) }
      let(:ticket2) { create(:ticket, title: 'QAチケット', description: 'これはQAのチケットです。¥n開発ようです', point: 1, user: current_user) }
 
      let(:params) do
        {
            'user_id': current_user.id,
            'keyword': 'テスト'
        }
      end
      let(:search_response) do
        [
           {
             id: ticket1.id,
             title: ticket1.title,
             description: ticket1.description 
           },
           {
             id: ticket2.id,
             title: ticket2.title,
             description: ticket2.description 
           },
        ]
      end

      it '検索キーワードに該当するチケットの一覧を返す' do
        # allow(ApplicationController).to receive(:current_user).and_return(current_user) 
        controller.stub(:current_user).and_return(current_user) 
        allow(TicketSearchQuery).to receive(:search).and_return(search_response) 

        get '/api/tickets/search', params: params
        results = response.body
        expect(results[0][:id]).to eq ticket1.id
        expect(results[1][:id]).to eq ticket2.id
      end
    end

    context '入力エラーを起こした場合' do
    end
  end
end