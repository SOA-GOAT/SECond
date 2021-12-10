# frozen_string_literal: true

require_relative '../../helpers/acceptance_helper'
require_relative 'pages/firm_page'
require_relative 'pages/home_page'

describe 'Firm Page Acceptance Tests' do
  include PageObject::PageFactory

  before do
    #DatabaseHelper.wipe_database
    # Delete `headless: true` if non-headless mode is preferred
    @browser = Watir::Browser.new :chrome, headless: true
  end

  after do
    @browser.close
  end

  it '(HAPPY) should see firm content if firm exists' do
    # GIVEN: user has requested and created a firm
    visit HomePage do |page|
      good_cik = CIK
      page.add_new_firm(good_cik)
    end

    # WHEN: user goes to the project page
    visit(FirmPage, using_params: { firm_cik: CIK }) do |page|
      # THEN: they should see the firm details
      _(page.firm_title).must_include FIRM_NAME
      _(page.firm_table_element.present?).must_equal true
      _(page.filings_table_element.present?).must_equal true

      # usernames = ['SOA-KunLin', 'Yuan-Yu', 'luyimin']
      # _(usernames.include?(page.contributors[0].username)).must_equal true
      # _(usernames.include?(page.contributors[1].username)).must_equal true
      # _(usernames.include?(page.contributors[3].username)).must_equal true

      _(page.filing_columns).must_equal ['Accession Number', 'Form Type', 'Filing Date', 'Reporting Date', 'Size']

      _(page.filing_columns.count).must_equal 5
    end
  end

  it '(HAPPY) should report an error if firm not requested' do
    # GIVEN: user has not requested a firm yet, even though it exists
    firm = SECond::Edgar::FirmMapper.new.find(CIK)
    SECond::Repository::For.entity(firm).create(firm)

    # WHEN: they go directly to the firm's page
    visit(FirmPage, using_params: { firm_cik: CIK })

    # THEN: they should should be returned to the homepage with a warning
    on_page HomePage do |page|
      _(page.warning_message.downcase).must_include 'request'
    end
  end
end
