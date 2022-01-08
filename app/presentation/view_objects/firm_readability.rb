# frozen_string_literal: true

module Views
  # View for a single firm entity
  class FirmTextualAttribute
    def initialize(firm_textual_attribute, index = nil)
      @firm_textual_attribute = firm_textual_attribute
      @index = index
    end

    def entity
      @firm_textual_attribute
    end

    def aver_firm_rdb
      @firm_textual_attribute.aver_firm_rdb
    end

    def aver_firm_sentiment
      @firm_textual_attribute.aver_firm_sentiment
    end

    def sentences
      @firm_textual_attribute.sentences
    end

    def size
      @firm_textual_attribute.size
    end

    def filings_textual_attribute
      @firm_textual_attribute.filings_textual_attribute
    end
  end
end
