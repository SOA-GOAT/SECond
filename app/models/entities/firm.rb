# frozen_string_literal: false

require 'dry-types'
require 'dry-struct'

require_relative 'filing'

module SECond
  module Entity
    # Domain entity for any firms
    class Firm < Dry::Struct
      include Dry.Types

      attribute :id,                Integer.optional
      attribute :cik,               Strict::String
      attribute :sic,               Strict::String
      attribute :sic_description,   Strict::String
      attribute :name,              Strict::String
      attribute :tickers,           Strict::String
      attribute :filings,           Strict::Array.of(Filing)

      def to_attr_hash
        to_hash.reject { |key, _| %i[id filings].include? key }
      end
    end
  end
end
