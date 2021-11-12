# frozen_string_literal: true

require 'sequel'

module SECond
  module Database
    # Object-Relational Mapper for Firms
    class FirmOrm < Sequel::Model(:firms)
      one_to_many :filings,
                  class: :'SECond::Database::FilingOrm',
                  key: :firm_id

      # many_to_many :contributed_projects,
      #              class: :'CodePraise::Database::ProjectOrm',
      #              join_table: :projects_members,
      #              left_key: :member_id, right_key: :project_id

      plugin :timestamps, update_on_create: true

      def self.find_or_create(firm_info)
        first(cik: firm_info[:cik]) || create(firm_info)
      end
    end
  end
end
