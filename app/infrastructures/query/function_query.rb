# frozen_string_literal: true
module Query
  class FunctionQuery
    class << self
      def match_query(field_name, value)
        { term: { field_name.to_sym => value } }
      end

      def full_text_query(field_names, keyword)
        {
          simple_query_string: {
            query: "/'#{keyword}/'",
            fields: field_names,
            default_operator: 'or'
          }
        }
      end
    end
  end
end