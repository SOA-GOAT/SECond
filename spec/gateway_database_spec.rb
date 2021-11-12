# frozen_string_literal: false

require_relative 'spec_helper'
require_relative 'helpers/vcr_helper'
require_relative 'helpers/database_helper'

describe 'Integration Tests of Edgar API and Database' do
  VcrHelper.setup_vcr

  before do
    VcrHelper.configure_vcr_for_github
  end

  after do
    VcrHelper.eject_vcr
  end

  describe 'Retrieve and store firm' do
    before do
      DatabaseHelper.wipe_database
    end

    it 'HAPPY: should be able to save firm from Edgar to database' do
      firm = SECond::Edgar::FirmMapper.new.find(CIK)
      rebuilt = SECond::Repository::For.entity(firm).create(firm)

      _(rebuilt.sic).must_equal(firm.sic)
      _(rebuilt.sic_description).must_equal(firm.sic_description)
      _(rebuilt.name).must_equal(firm.name)
      _(rebuilt.tickers).must_equal(firm.tickers)

      # wait to debug
      firm.filings.each do |filing|
        found = rebuilt.filings.find do |potential|
          potential.accession_number == filing.accession_number
        end

        _(found.accession_number).must_equal filing.accession_number
        # not checking email as it is not always provided
      end
    end
  end
end
