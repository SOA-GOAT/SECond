# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

require_relative 'sentence_textual_attribute_representer'

module SECond
  module Representer
    # Represents sentence info about firm's filing
    class FilingTextualAttribute < Roar::Decorator
      include Roar::JSON

      # property :sentences
      property :filing_rdb
      property :filing_sentiment
      property :word_frequency
    end
  end
end
