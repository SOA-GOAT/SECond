# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

module SECond
  module Representer
    # Represents sentence info about firm's filing
    class SentenceTextualAttribute < Roar::Decorator
      include Roar::JSON

      property :sentence
    end
  end
end
