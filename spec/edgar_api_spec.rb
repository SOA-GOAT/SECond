# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require_relative '../lib/edgar_api'

CIK = '0000320193'
CORRECT = YAML.safe_load(File.read('spec/fixtures/edgar_results.yml'))

describe 'Tests Edgar API library' do
  describe 'Submission information' do
    it 'HAPPY: should provide correct submission attributes' do
      submission = SECond::EdgarApi.new().submission(CIK)
      _(submission.sic).must_equal CORRECT['sic']
      _(submission.sic_description).must_equal CORRECT['sicDescription']
      _(submission.name).must_equal CORRECT['name']
      _(submission.tickers).must_equal CORRECT['tickers']
    end
    it 'SAD: should raise exception on incorrect submission' do
      _(proc do
        SECond::EdgarApi.new().submission('0000000000')
      end).must_raise SECond::EdgarApi::Errors::NotFound
    end
  end
end