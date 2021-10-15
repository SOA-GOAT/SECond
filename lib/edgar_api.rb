# frozen_string_literal: true

require 'http'
require_relative 'submission'

module SECond
  # Library for EDGAR API
  class EdgarApi
    API_ROOT = 'https://data.sec.gov'

    module Errors
      class NotFound < StandardError; end
      class Unauthorized < StandardError; end # rubocop:disable Layout/EmptyLineBetweenDefs
    end

    HTTP_ERROR = {
      401 => Errors::Unauthorized,
      404 => Errors::NotFound
    }.freeze

    def initialize()
    end

    def submission(cik)
      submission_req_url = submission_api_path(cik)
      submission_data = call_submission_url(submission_req_url).parse
      Submission.new(submission_data, self)
    end

    private

    def submission_api_path(cik)
      "#{API_ROOT}/CIK#{cik}.json"
    end

    def call_submission_url(url)
      result =
        HTTP.headers('Accept' => '*/*',
                     'Connection' => 'keep-alive')
            .get(url)

      successful?(result) ? result : raise(HTTP_ERROR[result.code])
    end

    def successful?(result)
      !HTTP_ERROR.keys.include?(result.code)
    end
  end
end
