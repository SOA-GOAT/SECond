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
      property :filing_rdb # aver_firm_readability
      property :sentiment_score # filing's sentiment score
      property :word_frequency
    end
  end
end
