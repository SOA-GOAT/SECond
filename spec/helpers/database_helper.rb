# frozen_string_literal: true

# Helper to clean database during test runs
module DatabaseHelper
  def self.wipe_database
    # Ignore foreign key constraints when wiping tables
    SECond::App.DB.run('PRAGMA foreign_keys = OFF')
    SECond::Database::FilingOrm.map(&:destroy)
    SECond::Database::FirmOrm.map(&:destroy)
    SECond::App.DB.run('PRAGMA foreign_keys = ON')
  end
end
