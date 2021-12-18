# frozen_string_literal: true

require 'dry/transaction'

module SECond
  module Service
    # Retrieves array of all listed firm entities
    class ListFirms
      include Dry::Transaction

      step :get_api_list
      step :reify_list

      private

      def get_api_list(firms_list)
        Gateway::Api.new(SECond::App.config)
          .firms_list(firms_list)
          .then do |result|
            result.success? ? Success(result.payload) : Failure(result.message)
          end
      rescue StandardError
        Failure('Could not access our API')
      end

      def reify_list(firms_json)
        Representer::FirmsList.new(OpenStruct.new)
          .from_json(firms_json)
          .then { |firms| Success(firms) }
      rescue StandardError
        Failure('Could not parse response from API')
      end
    end
  end
end
