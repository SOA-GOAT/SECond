# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

require_relative 'openstruct_with_links'
require_relative 'firm_representer'

module SECond
  module Representer
    # Represents list of firms for API output
    class FirmsList < Roar::Decorator
      include Roar::JSON

      collection :firms, extend: Representer::Firm,
                         class: Representer::OpenStructWithLinks
    end
  end
end
