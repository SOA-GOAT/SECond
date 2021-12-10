# # frozen_string_literal: true

# require_relative '../../../helpers/spec_helper.rb'

# describe 'Integration test of AddFirm service and API gateway' do
#   it 'must get the appraisal of an existing firm' do
#     req = OpenStruct.new(
#       firm_fullname: USERNAME + '/' + PROJECT_NAME,
#       owner_name: USERNAME,
#       firm_name: PROJECT_NAME,
#       foldername: ''
#     )
#     watched_list = [req.firm_fullname]

#     # WHEN we request to add a firm
#     res = SECond::Service::InspectFirm.new.call(
#       watched_list: watched_list, requested: req
#     )

#     # THEN we should see a single firm in the list
#     _(res.success?).must_equal true
#     appraisal = res.value!
#     _(appraisal.to_h.keys.sort).must_equal %i[folder firm]
#     _(appraisal.firm.owner.username).must_equal USERNAME
#     _(appraisal.folder.any_base_files?).must_equal true
#   end
# end