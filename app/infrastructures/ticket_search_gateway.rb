# frozen_string_literal: true

class TicketSearchGateway
  class << self
    def call(user_id: user_id, keyword: keyword)
      result_record = ElasticsearchClient.client.search(query(user_id, keyword))
    end

    private

    def query call(user_id, keyword)
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
                    field: "likes",
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
            }
          # TODO: aggregationを設定する
          # },
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
        }.to_json
      end
    end
  end
end
