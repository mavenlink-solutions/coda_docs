module CodaDocs
  module Entities
    class Entity
      def initialize(access_token)
        @access_token = access_token
      end

      def parse_response(response, field: 'items')
        response.parsed_response[field]
      end

      def connection
        conn = CodaDocs::Connection
        conn.default_options.merge!(
          headers: {
            'Authorization' => "Bearer #{@access_token}",
            'Content-Type' => 'application/json'
          }
        )
        conn
      end

      def paginate_response(response)
        response_list = parse_response(response)

        raise CodaDocs::ResponseError, "Could not retrieve entity. Either entity does not exist or you do not have authorization to access the entity." if response_list.nil?

        while parse_response(response, field: 'nextPageLink')
          response = connection.get(parse_response(response, field: 'nextPageLink'))
          response_list << parse_response(response)
        end

        response_list.flatten
      end
    end
  end
end


