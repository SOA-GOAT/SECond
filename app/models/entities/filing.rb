# frozen_string_literal: false

require 'dry-types'
require 'dry-struct'

# require_relative 'member' # Another entity.rb

module SECond
  module Entity
    # Domain entity for any firms
    class Filing < Dry::Struct
      include Dry.Types

      attribute :id,                Integer.optional
      attribute :cik,               Strict::String
      attribute :accession_number,  Strict::String
      attribute :form_type,         Strict::String
      attribute :filing_date,       Strict::String
      attribute :reporting_date,    Strict::String
      attribute :size,              Strict::Integer

      def to_attr_hash
        to_hash.reject { |key, _| %i[id].include? key }
      end
    end
  end
end
