# frozen_string_literal: true

require 'figaro'
require 'roda'
require 'sequel'
require 'delegate' # needed until Rack 2.3 fixes delegateclass bug

module SECond
  # Configuration for the App
  class App < Roda
    plugin :environments

    # rubocop:disable Lint/ConstantDefinitionInBlock
    # Environment variables setup
    Figaro.application = Figaro::Application.new(
      environment: environment,
      path: File.expand_path('config/secrets_example.yml')
    )
    Figaro.load
    def self.config() = Figaro.env

    use Rack::Session::Cookie, secret: config.SESSION_SECRET

    configure :development, :test, :app_test do
      ENV['DATABASE_URL'] = "sqlite://#{config.DB_FILENAME}"
    end

    configure :app_test do
      require_relative '../spec/helpers/vcr_helper.rb'
      VcrHelper.setup_vcr
      VcrHelper.configure_vcr_for_edgar(recording: :none)
    end

    # Database Setup
    DB = Sequel.connect(ENV['DATABASE_URL'])
    # This method smells of :reek:UncommunicativeMethodName
    def self.DB() = DB # rubocop:disable Naming/MethodName
    # rubocop:enable Lint/ConstantDefinitionInBlock
  end
end
