# frozen_string_literal: false

module SECond
  module Edgar
    # Data Mapper: Edgar Submission -> Submission entity
    class FilingMapper
      def initialize(gateway_class = Edgar::EdgarApi)
        @gateway_class = gateway_class
        @gateway = @gateway_class.new
      end

      def load_several(cik)
        filing_hash = @gateway.submission_data(cik)
        keys = filing_hash.keys
        size = filing_hash['accessionNumber'].size
        (0..size - 1).map do |index|
          data = {}
          keys.each { |key| data[key] = filing_hash[key][index] }
          FilingMapper.build_entity(data, cik)
        end
      end

      def self.build_entity(data, cik)
        data['cik'] = cik
        DataMapper.new(data).build_entity
      end

      # Extracts entity specific elements from data structure
      class DataMapper
        def initialize(data)
          @data = data
        end

        def build_entity
          Entity::Filing.new(
            id: nil,
            cik: cik,
            accession_number: accession_number,
            form_type: form_type,
            filing_date: filing_date,
            reporting_date: reporting_date,
            size: size
          )
        end

        private

        def cik
          @data['cik']
        end

        def accession_number
          @data['accessionNumber']
        end

        def form_type
          @data['form']
        end

        def filing_date
          @data['filingDate']
        end

        def reporting_date
          @data['reportDate']
        end

        def size
          @data['size']
        end
      end
    end
  end
end
