# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

require_relative 'sentence_readability_representer'
require_relative 'filing_readability_representer'

module SECond
  module Representer
    # Represents sentence info about firm's filing
    class FirmReadability < Roar::Decorator
      include Roar::JSON

      property :firm_rdb, extend: Representer::FilingReadability, class: OpenStruct
    end
  end
end
