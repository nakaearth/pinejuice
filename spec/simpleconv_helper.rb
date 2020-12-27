# frozen_string_literal: true
require 'simplecov'

if ENV['CIRCLE_ARTIFACTS']
  dir = File.join('..', '..', '..', ENV['CIRCLE_ARTIFACTS'], 'coverage')
  SimpleCov.coverage_dir(dir)
end
# NOTE: coverageで90％以下の場合はCIのテストを落とす
# SimpleCov.minimum_coverage 90
# NOTE: SimpleCov.startはinitializer
SimpleCov.start 'rails' do
  add_group 'Services', 'app/usecases'
  add_group 'Services', 'app/queries'
  add_group 'Workers', 'app/workers'

  add_filter '/vendor/'
  add_filter 'app/controllers/application_controller.rb'
end
