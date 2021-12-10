# frozen_string_literal: true

require 'dry/transaction'

module SECond
  module Service
    # Transaction to store firm from Edgar API to database
    class AddFirm
      include Dry::Transaction

      step :format_cik
      step :request_firm
      step :reify_firm

      private

      def format_cik(input)
        if input.success?
          firm_cik = format('%010d', input[:firm_cik].to_i)
          Success(firm_cik: firm_cik)
        else
          Failure("CIK #{input.errors.messages.first}")
        end
      end

      def request_firm(input)
        result = Gateway::Api.new(SECond::App.config)
          .add_firm(input[:firm_cik])

        result.success? ? Success(result.payload) : Failure(result.message)
      rescue StandardError => e
        puts e.inspect + '\n' + e.backtrace
        Failure('Cannot add firms right now; please try again later')
      end

      def reify_firm(firm_json)
        Representer::Firm.new(OpenStruct.new)
          .from_json(firm_json)
          .then { |firm| Success(firm) }
      rescue StandardError
        Failure('Error in the firm -- please try again')
      end
    end
  end
end
