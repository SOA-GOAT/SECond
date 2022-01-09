# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'
require_relative 'firm_representer'

# Represents essential Firm information for API output
module SECond
  module Representer
    # Representer object for firm download requests
    class DownloadRequest < Roar::Decorator
      include Roar::JSON

      property :firm, extend: Representer::Firm, class: OpenStruct
      property :id
    end
  end
end
