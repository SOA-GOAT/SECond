# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

module SECond
  module Representer
    # Represents essential Filing information for API output
    # USAGE:
    #   filing = Database::FilingOrm.find(1)
    #   Representer::Filing.new(filing).to_json
    class Filing < Roar::Decorator
      include Roar::JSON

      property :id
      property :cik
      property :accession_number
      property :form_type
      property :filing_date
      # property :reporting_date
      property :primary_document
      property :size
    end
  end
end
