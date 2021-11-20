# frozen_string_literal: true

require_relative 'firm'

module Views
  # View for a a list of firm entities
  class FirmsList
    def initialize(firms)
      @firms = firms.map.with_index { |firm, i| Firm.new(firm, i) }
    end

    def each
      @firms.each do |firm|
        yield firm
      end
    end

    def any?
      @firms.any?
    end
  end
end
