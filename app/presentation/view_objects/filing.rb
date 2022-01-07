# frozen_string_literal: true

module Views
  # View for a single filing entity
  class Filing
    def initialize(filing, filing_rdb, index = nil)
      @filing = filing
      @filing_rdb = filing_rdb
      @index = index
    end

    def entity
      @filing
    end

    def index_str
      "filling[#{@index}]"
    end

    def cik
      @filing.cik
    end

    def accession_number
      @filing.accession_number
    end

    def form_type
      @filing.form_type
    end

    def filing_date
      @filing.filing_date
    end

    def reporting_date
      @filing.reporting_date
    end

    def primary_document
      @filing.primary_document
    end

    def size
      @filing.size
    end

    def rdb_score
      @filing_rdb.filing_rdb
    end

    def document_path
      accession_number = @filing.accession_number.tr('-', '')
      cik = @filing.cik.to_i.to_s
      path = "https://www.sec.gov/Archives/edgar/data"
      "#{path}/#{cik}/#{accession_number}/#{@filing.primary_document}"
    end
  end
end
