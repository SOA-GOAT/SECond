# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:filings_firms) do
      primary_key %i[filing_id firm_id]
      foreign_key :filing_id, :filings
      foreign_key :firm_id, :firms

      index %i[filing_id firm_id]
    end
  end
end
