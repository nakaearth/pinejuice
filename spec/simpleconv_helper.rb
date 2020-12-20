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
  add_filter '/vendor/'
  add_filter 'app/controllers/mock'
  add_filter 'app/controllers/concerns/mock_handlers.rb'
  add_filter 'app/controllers/concerns/stub_platform_api_handlers.rb'

  add_group 'Services', 'app/services'
  add_group 'Workers', 'app/workers'

  # NOTE: 現状はskip.
  # 処理が増えてきた場合はテストを作成し、add_filterを削除する
  add_filter 'app/controllers/application_controller.rb'
  add_filter 'app/controllers/api/students/application_controller.rb'
end
