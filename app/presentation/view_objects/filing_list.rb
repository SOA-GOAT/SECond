# frozen_string_literal: true

require_relative 'filing'

module Views
  # View for a a list of filing entities
  class FilingsList
    def initialize(filings, firm_textual_attribute)
      filings_textual_attribute = firm_textual_attribute.filings_textual_attribute
      @filings = filings.map.with_index { |filing, index| Filing.new(filing, filings_textual_attribute[index], index) }
      
    end

    def each
      @filings.each do |filing|
        yield filing
      end
    end

    def any?
      @filings.any?
    end

    def map
      @filings.map do |filing|
        yield filing
      end
    end

    def filter
      @filings.filter do |filing|
        yield filing
      end
    end
  end
end
