# frozen_string_literal: true

module Views
  # View for a single project entity
  class Firm
    def initialize(firm, firm_textual_attribute, index = nil)
      @firm = firm
      @firm_textual_attribute = firm_textual_attribute
      @index = index
    end

    def entity
      @firm
    end

    def firm_link
      "/firm/#{cik}"
    end

    def index_str
      "firm[#{@index}]"
    end

    def cik
      @firm.cik
    end

    def sic
      @firm.sic
    end

    def sic_description
      @firm.sic_description
    end

    def name
      @firm.name
    end

    def tickers
      @firm.tickers
    end

    def aver_firm_rdb
      @firm_textual_attribute.aver_firm_rdb
    end

    def aver_firm_sentiment
      @firm_textual_attribute.aver_firm_sentiment
    end
  end
end
