# frozen_string_literal: true

module Query
  class AndQueryString
    KEYWORD = 'keyword'
    TERM = 'term'

    class << self
      def and_queries(search_conditions)
        search_conditions.map do |search_condition|
          and_query(search_condition[:search_type],
                    search_condition[:column],
                    search_condition[:search_word])
        end
      end

      private

      def and_query(search_type, column, search_word)
        case search_type
        when KEYWORD
          match_query(column, search_word)
        when TERM
          type_terms_query(column, search_word)
        end
      end

      def type_terms_query(column, search_word)
        { term: { "#{column}": search_word } }
      end

      def match_query(column, search_word)
        {
          simple_query_string: {
            query: search_word,
            fields: [column],
            default_operator: 'and'
          }
        }
      end
    end
  end
end
