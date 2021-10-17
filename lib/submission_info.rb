# frozen_string_literal: true

require 'http'
require 'yaml'

# config = YAML.safe_load(File.read('config/secrets.yml'))

def edgar_api_path(path)
  "https://data.sec.gov/#{path}"
end

def call_edgar_url(url)
  HTTP.headers('Accept' => '*/*',
               'Connection' => 'keep-alive').get(url)
end

# 'Accept-Encoding' => 'gzip, deflate, br',

edgar_response = {}
edgar_results = {}

## HAPPY submission request
submission_url = edgar_api_path('submissions/CIK0000320193.json')
edgar_response[submission_url] = call_edgar_url(submission_url)
submission = edgar_response[submission_url].parse

edgar_results['sic'] = submission['sic']
# should be 3571

edgar_results['sicDescription'] = submission['sicDescription']
# should be Electronic Computers

edgar_results['name'] = submission['name']
# should be Apple Inc.

edgar_results['tickers'] = submission['tickers']
# should be a list ["AAPL"]

### second layer data ###
# contributors_url = submission['contributors_url']
# edgar_response[contributors_url] = call_edgar_url()
# contributors = edgar_response[contributors_url].parse

# edgar_results['contributors'] = contributors
# contributors.count
# # should be 3 contributors array

# contributors.map { |c| c['login'] }
# # should be ["Yuan-Yu", "SOA-KunLin", "luyimin"]

## BAD submission request
bad_submission_url = edgar_api_path('submissions/CIK0000000000.json')
edgar_response[bad_submission_url] = call_edgar_url(submission_url)
edgar_response[bad_submission_url].parse # makes sure any streaming finishes

File.write('spec/fixtures/edgar_results.yml', edgar_results.to_yaml)
