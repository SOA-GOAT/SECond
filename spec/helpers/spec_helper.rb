# frozen_string_literal: true

ENV['RACK_ENV'] ||= 'test'

require 'simplecov'
SimpleCov.start

require 'yaml'

require 'minitest/autorun'
require 'minitest/rg'

require_relative '../../init'

CIK = '0000320193'
FIRM_NAME = 'Apple Inc.'

# Helper method for acceptance tests
def homepage
  SECond::App.config.APP_HOST
end
