# frozen_string_literal: true

module SECond
  # Model for Project
  class Submission
    def initialize(submission_data)
      @submission = submission_data
    end

    def sic
      @submission['sic']
    end

    def sic_description
      @submission['sicDescription']
    end

    def name
      @submission['name']
    end

    def tickers
      @submission['tickers']
    end

  end
end
