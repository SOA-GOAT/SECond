# frozen_string_literal: true

require_relative 'filings'

module SECond
  module Repository
    # Repository for Firms
    class Firms
      def self.all
        Database::FirmOrm.all.map { |db_firm| rebuild_entity(db_firm) }
      end
      ### Use data from 2 entity
      # def self.find_full_name(owner_name, project_name)
      #   # SELECT * FROM `projects` LEFT JOIN `members`
      #   # ON (`members`.`id` = `projects`.`owner_id`)
      #   # WHERE ((`username` = 'owner_name') AND (`name` = 'project_name'))
      #   db_project = Database::FirmOrm
      #     .left_join(:members, id: :owner_id)
      #     .where(username: owner_name, name: project_name)
      #     .first
      #   rebuild_entity(db_project)
      # end

      def self.find(entity)
        find_cik(entity.cik)
      end

      def self.find_cik(cik)
        db_record = Database::FirmOrm.first(cik: cik)
        rebuild_entity(db_record)
      end

      def self.find_name(name)
        db_record = rebuild_entity Database::FirmOrm.first(name: name)
        rebuild_entity(db_record)
      end

      def self.create(entity)
        raise 'Firm already exists' if find(entity)

        db_firm = PersistFirm.new(entity).call
        rebuild_entity(db_firm)
      end

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::Firm.new(
          db_record.to_hash.merge(
            # firm: Submissions.rebuild_entity(db_record.firm),
            filings: Filings.rebuild_many(db_record.filings)
          )
        )
      end

      # Helper class to persist firm and its submissions to database
      class PersistFirm
        def initialize(entity)
          @entity = entity
        end

        def create_firm
          Database::FirmOrm.create(@entity.to_attr_hash)
        end

        def call
          # submission = Submissions.db_find_or_create(@entity)

          create_firm.tap do |db_firm|
            # db_firm.update(submission: submission)

            @entity.filings.each do |filing|
              db_firm.add_filing(Filings.db_find_or_create(filing))
            end
          end
        end
      end
    end
  end
end
