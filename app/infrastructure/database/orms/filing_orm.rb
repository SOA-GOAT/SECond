# frozen_string_literal: true

require 'sequel'

module SECond
  # Database for SECond
  module Database
    # Object Relational Mapper for Submission Entities
    class FilingOrm < Sequel::Model(:filings)
      many_to_one :firm,
                  class: :'SECond::Database::FirmOrm'

      # many_to_many :contributors,
      #              class: :'CodePraise::Database::MemberOrm',
      #              join_table: :projects_members,
      #              left_key: :project_id, right_key: :member_id

      plugin :timestamps, update_on_create: true

      def self.find_or_create(filing_info)
        first(accession_number: filing_info[:accession_number]) || create(filing_info)
      end
    end
  end
end
