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
        input[:response] = Gateway::Api.new(SECond::App.config)
          .inspect(input[:requested])
        input[:response].success? ? Success(input) : Failure(input[:response].message)
      rescue StandardError => e
        puts e
        Failure('Cannot inspect firms right now; please try again later')
      end

      def reify_readability(input)
        unless input[:response].processing?
          Representer::FirmTextualAttribute.new(OpenStruct.new)
            .from_json(input[:response].payload)
            .then { input[:inspected] = _1 }
        end

        Success(input)
      rescue StandardError
        Failure('Error in our inspect report -- please try again')
      end
    end
  end
end
