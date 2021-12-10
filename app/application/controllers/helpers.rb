# frozen_string_literal: true

module SECond
  module RouteHelpers
    # Application value for the path of a requested firm
    class FirmRequestPath

      def initialize(cik, request)
        @firm_cik = cik
        @request = request
        @path = request.remaining_path
      end

      attr_reader :firm_cik

    end
  end
end

