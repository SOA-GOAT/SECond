# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:filings) do
      primary_key :id
      foreign_key :firm_id, :firms

      String      :cik
      String      :accession_number, unique: true
      String      :form_type
      String      :filing_date
      String      :reporting_date
      Integer     :size

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
