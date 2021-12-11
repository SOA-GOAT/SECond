# frozen_string_literal: true

require_relative 'list_request'
require 'http'

module SECond
  module Gateway
    # Infrastructure to call SECond API
    class Api
      def initialize(config)
        @config = config
        @request = Request.new(@config)
      end

      def alive?
        @request.get_root.success?
      end

      def firms_list(list)
        @request.firms_list(list)
      end

      def add_firm(firm_cik)
        @request.add_firm(firm_cik)
      end

      # Gets readability of a firm folder rom API
      # - req: FirmRequestPath
      #        with #owner_name, #firm_name, #folder_name, #firm_fullname
      def inspect(req)
        @request.get_inspection(req)
      end

      # HTTP request transmitter
      class Request
        def initialize(config)
          @api_host = config.API_HOST
          @api_root = config.API_HOST + '/api/v1'
        end

        def get_root # rubocop:disable Naming/AccessorMethodName
          call_api('get')
        end

        def firms_list(list)
          call_api('get', ['firms'],
                   'list' => Value::WatchedList.to_encoded(list))
        end

        def add_firm(firm_cik)
          call_api('post', ['firms', firm_cik])
        end

        # def get_inspection(req)
        #   call_api('get', ['firms',
        #                    req.firm_cik, req.readability])
        # end

        private

        def params_str(params)
          params.map { |key, value| "#{key}=#{value}" }.join('&')
            .then { |str| str ? '?' + str : '' }
        end

        def call_api(method, resources = [], params = {})
          api_path = resources.empty? ? @api_host : @api_root
          url = [api_path, resources].flatten.join('/') + params_str(params)
          HTTP.headers('Accept' => 'application/json').send(method, url)
            .then { |http_response| Response.new(http_response) }
        rescue StandardError
          raise "Invalid URL request: #{url}"
        end
      end

      # Decorates HTTP responses with success/error
      class Response < SimpleDelegator
        NotFound = Class.new(StandardError)

        SUCCESS_CODES = (200..299) # .freeze

        def success?
          code.between?(SUCCESS_CODES.first, SUCCESS_CODES.last)
        end

        def message
          payload['message']
        end

        def payload
          body.to_s
        end
      end
    end
  end
end
