# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:submissions_firms) do
      primary_key %i[submission_id firm_id]
      foreign_key :submission_id, :submissions
      foreign_key :firm_id, :firms

      index %i[submission_id firm_id]
    end
  end
end
