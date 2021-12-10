# frozen_string_literal: true

require_relative '../../../helpers/spec_helper.rb'

describe 'Integration test of AddFirm service and API gateway' do
  it 'must add a legitimate firm' do
    # WHEN we request to add a firm
    url_request = SECond::Forms::NewFirm.new.call(firm_CIK: CIK)

    res = SECond::Service::AddFirm.new.call(url_request)

    # THEN we should see a single firm in the list
    _(res.success?).must_equal true
    firm = res.value!
    _(firm.name).must_equal FIRM_NAME
  end
end