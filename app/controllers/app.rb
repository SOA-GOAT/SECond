# frozen_string_literal: true

require 'roda'
require 'slim'

module SECond
  # Web App
  class App < Roda
    plugin :render, engine: 'slim', views: 'app/views'
    plugin :public, root: 'app/views/public'
    plugin :assets, path: 'app/views/assets',
                    css: 'style.css', js: 'table_row_click.js'
    plugin :halt

    route do |routing| # rubocop:disable Metrics/BlockLength
      routing.assets # load CSS
      routing.public

      # GET /
      routing.root do
        edgar_firm = Repository::For.klass(Entity::Firm).all
        view 'home', locals: { firm: edgar_firm }
      end

      routing.on 'firm' do
        routing.is do
          # POST /firm/
          routing.post do
            firm_cik = routing.params['firm_cik']

            routing.halt 400 unless (firm_cik.is_a? String) &&
                                    (firm_cik.size <= 10)

            firm_cik = format('%010d', firm_cik.to_i)
            
            edgar_firm = Repository::For.klass(Entity::Firm).find_cik(firm_cik) 
            if edgar_firm.nil? == false
              routing.redirect "firm/#{firm_cik}"
            end
            
            # Get filing from Firm
            firm = Edgar::FirmMapper
              .new
              .find(firm_cik)

            # Add filing to database
            Repository::For.entity(firm).create(firm)

            # Redirect viewer to filing page
            routing.redirect "firm/#{firm_cik}"
          end
        end

        routing.on String do |firm_cik|
          # GET /firm/firm_cik
          routing.get do
            # Get firm from database
            edgar_firm = Repository::For.klass(Entity::Firm)
              .find_cik(firm_cik)

            # Download 10-Ks from project information
            # api = Edgar::EdgarApi.new
            # firm_filings = edgar_firm.filings.select { |filing| filing.form_type.include? "10-K"}
            # firm_filings.each do |filing|
            # api.download_submission_url(firm_cik, filing.accession_number)
            #firm_filings = FirmFiling.new(edgar_firm)
            #firm_filings.download! unless firm_filings.exists_locally?
            # end

            # Compile readability for firm specified by cik
            #firm_rdb = Mapper::Readability
            #  .new.for_firm(firm_cik)

            # Show viewer the firm
            view 'firm', locals: { firm: edgar_firm }
          end
        end
      end
    end
  end
end
