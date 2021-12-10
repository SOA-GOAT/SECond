# frozen_string_literal: true

require_relative '../../helpers/acceptance_helper'
require_relative 'pages/home_page'

describe 'Homepage Acceptance Tests' do
  include PageObject::PageFactory
  before do
    #DatabaseHelper.wipe_database

    # Delete `headless: true` if non-headless mode is preferred
    @browser = Watir::Browser.new :chrome, headless: true
  end

  after do
    @browser.close
  end

  describe 'Visit Home page' do
    it '(HAPPY) should not see firms if none created' do
      # GIVEN: user has no firms
      # WHEN: they visit the home page
      visit HomePage do |page|
        # THEN: they should see basic headers, no firms and a welcome message
        # _(page.title_heading).must_equal 'SECond'
        _(page.cik_input_element.present?).must_equal true
        _(page.add_button_element.present?).must_equal true
        _(page.firms_table_element.exists?).must_equal false

        _(page.success_message_element.present?).must_equal true
        _(page.success_message.downcase).must_include 'start'
      end
    end

    it '(HAPPY) should not see firms they did not request' do
      # GIVEN: a firm exists in the database but user has not requested it
      firm = SECond::Edgar::FirmMapper.new.find(CIK)
      SECond::Repository::For.entity(firm).create(firm)

      # WHEN: user goes to the homepage
      visit HomePage do |page|
        # THEN: they should not see any firms
        _(page.firms_table_element.exists?).must_equal false
      end
    end
  end

  describe 'Add Firm' do
    it '(HAPPY) should be able to request a firm' do
      # GIVEN: user is on the home page without any firms

      visit HomePage do |page|
        # WHEN: they add a firm URL and submit
        good_cik = CIK
        page.add_new_firm(good_cik)

        # THEN: they should find themselves on the project's page
        @browser.url.include? 'firm'
        @browser.url.include? CIK
      end
    end

    it '(HAPPY) should be able to see requested firms listed' do
      # GIVEN: user has requested a firm
      visit HomePage do |page|
        good_cik = CIK
        page.add_new_firm(good_cik)
      end

      # WHEN: they return to the home page
      visit HomePage do |page|
        # THEN: they should see their firm's details listed
        _(page.firms_table_element.exists?).must_equal true
        _(page.num_firms).must_equal 1
        _(page.first_firm.text).must_include CIK
      end
    end

    it '(HAPPY) should see firm highlighted when they hover over it' do
      # GIVEN: user has requested a firm to watch
      good_cik = CIK
      visit HomePage do |page|
        page.add_new_firm(good_cik)
      end

      # WHEN: they go to the home page
      visit HomePage do |page|
        # WHEN: ..and hover over their new firm
        page.first_firm_hover

        # THEN: the new firm should get highlighted
        _(page.first_firm_highlighted?).must_equal true
      end
    end

    it '(BAD) should not be able to add an invalid firm cik' do
      # GIVEN: user is on the home page without any firms
      visit HomePage do |page|
        # WHEN: they request a firm with an invalid cik
        bad_cik = 'foobar'
        page.add_new_firm(bad_cik)

        # THEN: they should see a warning message
        _(page.warning_message.downcase).must_include 'invalid'
      end
    end

    it '(SAD) should not be able to add valid but non-existent firm cik' do
      # GIVEN: user is on the home page without any firms
      visit HomePage do |page|
        # WHEN: they add a firm cik that is valid but non-existent
        sad_cik = '0000000000'
        page.add_new_firm(sad_cik)

        # THEN: they should see a warning message
        _(page.warning_message.downcase).must_include 'could not find'
      end
    end
  end

  describe 'Delete Firm' do
    it '(HAPPY) should be able to delete a requested firm' do
      # GIVEN: user has requested and created a single firm
      visit HomePage do |page|
        good_cik = CIK
        page.add_new_firm(good_cik)
      end

      # WHEN: they revisit the homepage and delete the firm
      visit HomePage do |page|
        page.first_firm_delete

        # THEN: they should not find any firms
        _(page.firms_table_element.exists?).must_equal false
      end
    end
  end
end
