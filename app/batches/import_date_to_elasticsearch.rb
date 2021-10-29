# frozen_string_literal: true
require 'optparse'

# 1) 新規にindexを作成/データのimportをする場合
# bundle exec rails runner ImportDataToElasticsearch.execute
# 2) 既にindexがあって、再構築する場合
# bundle exec rails runner ImportDataToElasticsearch.execute --force=true
#
class ImportDataToElasticsearch
  class << self
    def execute
      logger = ActiveSupport::Logger.new("import_data_to_elasticsearch_batch.log", 'daily')

      # importする
      logger.info('========= データ登録 =========')
      ImportTicketToEsGateway.bulk_import
      logger.info('========データ登録完了しました ========')
    end

    private

    def args
      options = {}

      OptionParser.new do |o|
        o.banner = "Usage: #{$PROGRAM_NAME} [options]"
        o.on('--force=OPT', 'option1') { |v| options[:force] = v }
      end.parse!(ARGV.dup)

      options
    end
  end
end
