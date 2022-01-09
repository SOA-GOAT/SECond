# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

require_relative 'sentence_textual_attribute_representer'
require_relative 'filing_textual_attribute_representer'

module SECond
  module Representer
    # Represents sentence info about firm's filing
    class FirmTextualAttribute < Roar::Decorator
      include Roar::JSON

      collection :filings_textual_attribute, extend: Representer::FilingTextualAttribute, class: OpenStruct
      property :aver_firm_rdb
      property :aver_firm_sentiment
    end
  end
end
