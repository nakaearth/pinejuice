# frozen_string_literal: true

class TicketSearchGateway
  class << self
    def call(search_params)
      result_record = ElasticsearchClient.client.search(query(search_conditions: search_params))
    end

    private

    def query call(search_conditions: search_conditions, page_num: 0)
        {
          query: {
            function_score: {
              score_mode: 'sum', # functionsないのスコアの計算方法
              boost_mode: 'multiply', # クエリの合計スコアとfunctionのスコアの計算方法
              query: {
                bool: {
                  must: QueryBuilder::AndQueryString.and_queries(search_conditions),
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
          from: page_num,
          size: 10,
          sort: { id: { order: 'desc' } }
        }.to_json
      end
    end
  end
end
