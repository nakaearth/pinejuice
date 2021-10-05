# frozen_string_literal: true
module Search
  class ElasticsearchIndexGateway < BaseSearchInfrastructure
    class << self
      def create_index(index_name)
        Elasticsearch::Model.client = client_connection
        if Elasticsearch::Model.client.indices.exists? index: index_name
          Elasticsearch::Model.client.indices.delete index: index_name
        end

        Elasticsearch::Model.client.indices.create(
          index: index_name,
          body: {
            settings: Album.settings.to_hash,
            mappings: Album.mappings.to_hash
          }
        )
      end
    end
  end
end
