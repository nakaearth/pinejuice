# frozen_string_literal: true

class TicketSearchGateway
  class << self
    def call(user_id:, keyword:)
      config = YAML.load_file(Rails.root.join('config/elasticsearch.yml'))[ENV['RAILS_ENV'] || 'development']
      client = Elasticsearch::Client.new(host: config['host'])
      query =  query(user_id, keyword)
      response = client.search(index: 'es_tickets', body: query)

      { entries: response['hits']['hits'].map { |r_hash| r_hash['_source'] },
        total_count: response['hits']['total']['value'] }
    end

    private

    # rubocop:disable  Metrics/MethodLength
    def query(user_id, keyword)
      {
        query: {
          function_score: {
            query: {
              bool: {
                must: [
                  Query::FunctionQuery.match_query('user_id', user_id),
                  Query::FunctionQuery.full_text_query(['title^10', 'title2^3', 'description^8', 'description2^3'],
                                                       keyword)
                ]
              }
            },
            boost: 5,
            functions: [
              {
                field_value_factor: {
                  field: 'point',
                  factor: 2,
                  modifier: 'square',
                  missing: 1
                },
                weight: 5
              },
              {
                field_value_factor: {
                  field: 'id',
                  factor: 3,
                  modifier: 'sqrt', # squt: ルート, log: 指数関数
                  missing: 1
                },
                weight: 2
              }
            ],
            score_mode: 'sum', # functionsないのスコアの計算方法
            boost_mode: 'multiply' # クエリの合計スコアとfunctionのスコアの計算方法
          }
          # from: 50,
          # size: 10,
          # sort: { id: { order: 'desc' } }
        }
      }.to_json
    end
    # rubocop:enable  Metrics/MethodLength
  end
end
