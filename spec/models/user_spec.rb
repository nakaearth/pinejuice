# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model, ci: true do
  let(:user) { create(:user) }
end
