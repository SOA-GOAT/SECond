# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

require_relative 'sentence_readability_representer'

module SECond
  module Representer
    # Represents sentence info about firm's filing
    class FilingReadability < Roar::Decorator
      include Roar::JSON

      property :sentences
    end
  end
end
