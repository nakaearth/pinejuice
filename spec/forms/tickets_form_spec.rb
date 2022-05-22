# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TicketsForm, ci: true do
  let(:now) { '2022-04-01'.to_time }
  let(:login_user) { create(:user) }

  around do |e|
    travel_to(now.to_time) { e.run }
  end

  describe '#initialize' do
    context '数値型の値を渡した場合' do
      let(:search_parameters) do
        { 
          user_id: login_user.id 
        }
      end

      it 'formに渡されたuser_idがセットされる' do
        form = TicketsForm.new(search_parameters)
        expect(form.user_id).to eq login_user.id
      end
    end
    
    context '数値以外の値を渡した場合' do
      let(:search_parameters) do
        { 
          user_id: 'hogehoge'
        }
      end

      it 'formに渡されたuser_idがセットされる' do
        expect { TicketsForm.new(search_parameters) }.to raise_error(TicketSearchError)
      end
    end
  end
end