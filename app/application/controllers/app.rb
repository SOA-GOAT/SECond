# frozen_string_literal: true

require 'roda'
require 'slim'
require 'slim/include'
require_relative 'helpers'

module SECond
  # Web App
  class App < Roda
    include RouteHelpers

    plugin :halt
    plugin :flash
    plugin :all_verbs # allows DELETE and other HTTP verbs beyond GET/POST
    plugin :caching
    plugin :render, engine: 'slim', views: 'app/presentation/views_html'
    plugin :assets, path: 'app/presentation/assets',
                    css: 'style.css' # , js: 'table_row.js'

    use Rack::MethodOverride # for other HTTP verbs (with plugin all_verbs)

    route do |routing|
      routing.assets # load CSS

      # GET /
      routing.root do
        # Get cookie viewer's previously seen firms
        session[:watching] ||= []

        result = Service::ListFirms.new.call(session[:watching])

        if result.failure?
          flash[:error] = result.failure
          viewable_firms = []
        else
          firms = result.value!.firms
          flash.now[:notice] = 'Add a firm cik to get started' if firms.none?
          session[:watching] = firms.map(&:cik) # formatted_
          viewable_firms = Views::FirmsList.new(firms)
        end

        view 'home', locals: { firms: viewable_firms }
      end

      routing.on 'firm' do
        routing.is do
          # POST /firm/
          routing.post do
            cik_request = Forms::NewFirm.new.call(routing.params)
            firm_made = Service::AddFirm.new.call(cik_request)

            if firm_made.failure?
              flash[:error] = firm_made.failure
              routing.redirect '/'
            end

            firm = firm_made.value!
            puts firm_made
            session[:watching].insert(0, firm.cik).uniq!
            flash[:notice] = 'Firm added to your list'
            routing.redirect "firm/#{firm.cik}" # formatted_
          end
        end

        routing.on String do |firm_cik|
          # DELETE /firm/{firm_cik}
          routing.delete do
            session[:watching].delete(firm_cik)
            routing.redirect '/'
          end

          # GET /firm/{firm_cik}
          routing.get do
            session[:watching] ||= []

            result = Service::InspectFirm.new.call(
              watched_list: session[:watching],
              requested: firm_cik
            )

            if result.failure?
              flash[:error] = result.failure
              routing.redirect '/'
            end

            inspection = OpenStruct.new(result.value!)
            if inspection.response.processing?
              flash.now[:notice] = 'The firm is being inspected'
            else
              inspected = inspection.inspected
              firm_rdb = Views::FirmReadability
                .new(inspected[:firm_rdb]) # proj_folder
              response.expires(60, public: true) if App.environment == :production
            end

            processing = Views::InspectionProcessing.new(
              App.config, inspection.response
            )
            firm_list = SECond::Service::ListFirms.new.call([firm_cik]).value!.firms
            puts firm_list
            firm = firm_list.first
            # Show viewer the project
            view 'firm', locals: { firm: firm, firm_rdb: firm_rdb, processing: processing }
          end
        end
      end
    end
  end
end
