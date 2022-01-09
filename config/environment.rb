# frozen_string_literal: true

require 'figaro'
require 'roda'
require 'delegate' # needed until Rack 2.3 fixes delegateclass bug
require 'slim'

Slim::Engine.set_options use_html_safe: true, disable_escape: true

module SECond
  # Environment-specific configuration
  class App < Roda
    plugin :environments

    # Environment variables setup
    Figaro.application = Figaro::Application.new(
      environment: environment,
      path: File.expand_path('config/secrets_example.yml')
    )
    Figaro.load
    def self.config() = Figaro.env

    use Rack::Session::Cookie, secret: config.SESSION_SECRET

    configure :development, :test, :app_test do
      require 'pry'; # for breakpoints
    end
  end
end
