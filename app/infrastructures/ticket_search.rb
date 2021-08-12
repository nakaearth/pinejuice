# frozen_string_literal: true

module Search
  class TicketSearch
    class << self
      def call(search_params)
        query = QueryBuilder::StorySearch.call(search_params)
        result_record = ElasticsearchClient.client.searchc(query)
      end
    end
  end
end
