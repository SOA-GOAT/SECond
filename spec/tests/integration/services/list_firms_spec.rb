# frozen_string_literal: true

require_relative '../../../helpers/spec_helper.rb'

describe 'Integration test of ListFirms service and API gateway' do
  it 'must return a list of firms' do
    # GIVEN a firm is in the database
    SECond::Gateway::Api.new(SECond::App.config)
      .add_firm(CIK)

    # WHEN we request a list of firms
    list = [CIK]
    res = SECond::Service::ListFirms.new.call(list)

    # THEN we should see a single firm in the list
    _(res.success?).must_equal true
    list = res.value!
    _(list.firms.count).must_equal 1
    _(list.firms.first.name).must_equal FIRM_NAME
  end

  it 'must return and empty list if we specify none' do
    # WHEN we request a list of firms
    list = []
    res = SECond::Service::ListFirms.new.call(list)

    # THEN we should see a no firms in the list
    _(res.success?).must_equal true
    list = res.value!
    _(list.firms.count).must_equal 0
  end
end