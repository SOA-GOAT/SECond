# frozen_string_literal: true

module Views
    # View for a single firm entity
    class FirmReadability
      def initialize(firmrdb, index = nil)
        @firmrdb = firmrdb
        @index = index
      end
  
      def entity
        @firmrdb
      end
  
      def aver_firm_readability
        @firmrdb.aver_firm_readability
      end
  
      def sentences
        @firmrdb.sentences
      end
  
      def size
        @firmrdb.size
      end

    end
  end