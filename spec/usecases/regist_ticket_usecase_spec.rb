# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RegistTicketUsecase do
  describe '.execute' do
    let(:user) { create(:user, provider: 'twitter', email: 'hoge@gmail.com', name: 'ホゲ太郎') }

    context '正しくパラメータが渡ってきた場合' do
      it 'チケット登録が正しく行われる' do
        RegistTicketUsecase.execute(current_user: user,
                                    title: '今日のサーバ負荷調査',
                                    description: '朝の負荷状況を調べて共有します',
                                    point: 5)

        registed_tickets = Ticket.where(user: user).order('id desc')
        expect(registed_tickets.size).to eq 1
        expect(registed_tickets.first.title).to eq '今日のサーバ負荷調査'
      end
    end

    context 'エラーが発生した場合' do
      it '例外をraiseする' do
        expect do
          RegistTicketUsecase.execute(current_user: user,
                                      title: nil,
                                      description: '朝の負荷状況を調べて共有します',
                                      point: 5)
        end.to raise_error(RegistTicketError)
      end
    end
  end
end
