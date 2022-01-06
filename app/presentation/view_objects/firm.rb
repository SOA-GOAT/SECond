# frozen_string_literal: true

module Views
  # View for a single project entity
  class Firm
    def initialize(firm, firm_rdb, index = nil)
      @firm = firm
      @firm_rdb = firm_rdb
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
      @firm_rdb.aver_firm_rdb
    end
  end
end
