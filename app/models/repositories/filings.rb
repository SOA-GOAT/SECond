# frozen_string_literal: true

module SECond
  module Repository
    # Repository for Submissions
    class Filings
      def self.find_id(id)
        rebuild_entity Database::FilingOrm.first(id: id)
      end

      def self.find_accession_number(accession_number)
        rebuild_entity Database::FilingOrm.first(accession_number: accession_number)
      end

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::Filing.new(
          id: db_record.id,
          cik: db_record.cik,
          accession_number: db_record.accession_number,
          form_type: db_record.form_type,
          filing_date: db_record.filing_date,
          reporting_date: db_record.reporting_date,
          size: db_record.size
        )
      end

      def self.rebuild_many(db_records)
        db_records.map do |db_filing|
          Filings.rebuild_entity(db_filing)
        end
      end

      def self.db_find_or_create(entity)
        Database::FilingOrm.find_or_create(entity.to_attr_hash)
      end
    end
  end
end
