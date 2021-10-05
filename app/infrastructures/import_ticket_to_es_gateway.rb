# frozen_string_literal: true
module Search
  class AlbumToElasticsearchInsertGateway < BaseSearchInfrastructure
    class << self
      def bulk(index_name)
        Elasticsearch::Model.client = client_connection
        Album.find_in_batches.with_index do |entries, _i|
          Elasticsearch::Model.client.bulk(
            index: index_name,
            type: '_doc',
            body: entries.map { |entry| { index: { _id: entry.id, data: entry.as_indexed_json } } },
            refresh: true, # NOTE: 定期的にrefreshしないとEsが重くなる
          )
        end
      end
    end
  end
end
