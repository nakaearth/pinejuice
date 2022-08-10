# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TicketSearchForm, ci: true do
  let(:now) { '2022-04-01'.to_time }
  let(:login_user) { create(:user) }

  around do |e|
    travel_to(now.to_time) { e.run }
  end

  describe '#initialize' do
    describe 'user_idパラメータのチェック' do
      context 'user_idに数値型の値を渡した場合' do
        let(:search_parameters) do
          { 
            user_id: login_user.id 
          }
        end

        it 'formに渡されたuser_idがセットされる' do
          form = TicketSearchForm.new(search_parameters)
          expect(form.user_id).to eq login_user.id
        end
      end
      
      context 'user_idに数値以外の値を渡した場合' do
        let(:search_parameters) do
          { 
            user_id: 'hogehoge'
          }
        end

        it 'TicketSearchErrorがraiseされる' do
          expect { TicketSearchForm.new(search_parameters) }.to raise_error(TicketSearchError)
        end
      end
    end

    describe 'keywordパラメータのチェック' do
      context 'keywordに文字列型の値を渡した場合' do
        let(:search_parameters) do
          { 
            user_id: login_user.id,
            keyword: 'テスト' 
          }
        end

        it 'formに渡されたkeywordがセットされる' do
          form = TicketSearchForm.new(search_parameters)
          expect(form.keyword).to eq search_parameters[:keyword]
        end
      end
      
      context 'keywordに20文字以上の値をセットした場合' do
        let(:search_parameters) do
          { 
            user_id: login_user.id,
            keyword: '12345' * 4 + 'a'
          }
        end

        it 'エラーがraiseされる' do
          expect { TicketSearchForm.new(search_parameters) }.to raise_error(TicketSearchError)
        end
      end
    end
  end
end