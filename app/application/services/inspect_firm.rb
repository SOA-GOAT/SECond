# frozen_string_literal: true

require 'dry/transaction'

module SECond
  module Service
    # Analyzes contributions to a firm
    class InspectFirm
      include Dry::Transaction

      step :validate_firm
      step :retrieve_firm_readability
      step :reify_readability

      private

      def validate_firm(input)
        if input[:watched_list].include? input[:requested]
          Success(input)
        else
          Failure('Please first request this firm to be added to your list')
        end
      end

      def retrieve_firm_readability(input)
        result = Gateway::Api.new(SECond::App.config)
          .inspect(input[:requested])

        result.success? ? Success(result.payload) : Failure(result.message)
      rescue StandardError
        Failure('Cannot inspect firms right now; please try again later')
      end

      def reify_readabilityl(firm_readability_json)
        Representer::FirmReadability.new(OpenStruct.new)
          .from_json(firm_readability_json)
          .then { |firm_readability| Success(firm_readability) }
      rescue StandardError
        Failure('Error in our inspect report -- please try again')
      end
    end
  end
end
