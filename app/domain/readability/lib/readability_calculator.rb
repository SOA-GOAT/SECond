# frozen_string_literal: true

module SECond
    module Mixins
      # readability calculation methods
      module ReadabilityCalculator
        def line_count
          lines.map(&:credit).sum
        end
  
        def lines_by(contributor)
          lines.select { |line| line.contributor == contributor }
        end
  
        def total_credits
          lines.map(&:credit).sum
        end
  
        def credits_for(contributor)
          lines_by(contributor).map(&:credit).sum
        end
  
        def percent_credit_of(contributor)
          return 0 if line_count == 0 # for files with no creditable lines
          ((credits_for(contributor).to_f / line_count) * 100).round
        end
      end
    end
  end