# frozen_string_literal: true

class TicketSearchGateway
  class << self
    def call(user_id:, keyword:)
      config = YAML.load_file(Rails.root.join('config/elasticsearch.yml'))[ENV['RAILS_ENV'] || 'development']
      client  = Elasticsearch::Client.new(host: config['host'])
      query =  query(user_id, keyword)
      result_record = client.search(index: 'es_tickets', body: query)
      result_record
    end

    private

    def query(user_id, keyword)
      {
        query: {
          function_score: {
            score_mode: 'sum', # functionsないのスコアの計算方法
            boost_mode: 'multiply', # クエリの合計スコアとfunctionのスコアの計算方法
            query: {
              bool: {
                must: [
                  Query::FunctionQuery.match_query('user_id', user_id),
                  Query::FunctionQuery.full_text_query(['title^10', 'title2^3', 'description^8', 'description2^3'], keyword),
                ],
              }
            },
            functions: [
              {
                field_value_factor: {
                  field: "point",
                  factor: 2,
                  modifier: "square",
                  missing: 1
                },
                weight: 5
              },
              {
                field_value_factor: {
                  field: "id",
                  factor: 3,
                  modifier: "sqrt", # squt: ルート, log: 指数関数
                  missing: 1
                },
                weight: 2
              }
            ]
        # TODO: aggregationを設定する
        # aggs: {
        #   tag: {
        #     terms: {
        #       field: 'tag_name',
        #       size: 50
        #     }
        #   }
          },
          from: 50,
          size: 10,
          sort: { id: { order: 'desc' } }
        }
      }.to_json
    end
  end
end
