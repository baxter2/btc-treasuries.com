class Treasuries::PublicCompaniesController < ApplicationController
  public_companies  = %Q(
    <li class="flex">
      <div class="flex items-center">
        <svg class="h-full w-6 flex-shrink-0 text-gray-200" viewBox="0 0 24 44" preserveAspectRatio="none" fill="currentColor" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
          <path d="M.293 0l22 22-22 22h1.414l22-22-22-22H.293z" />
        </svg>
        <a href="/treasuries/public_companies" class="ml-4 text-sm font-medium text-gray-500 hover:text-gray-700">Public Companies</a>
      </div>
    </li>
  ).html_safe
  add_breadcrumb public_companies

  def index
    view_object = Treasuries::Entities.new("PublicCompany").call
    render locals: view_object.locals
  end

  def show
    @public_company = PublicCompany.find_by_permalink(params[:permalink])
    @transactions = @public_company.transactions
    @chart_data = Treasuries::ChartDataQuery.new(@transactions).group_by_individual
    @total_purchases = Treasuries::BtcStatisticsQuery.new(@transactions).total_purchases
    @total_sell_offs = Treasuries::BtcStatisticsQuery.new(@transactions).total_sell_offs
    @total_btc = Treasuries::BtcStatisticsQuery.new(@transactions).total_btc
    @total_percent_of_supply = Treasuries::BtcStatisticsQuery.new(@transactions).total_percent_of_supply

    public_company = %Q(
      <li class="flex">
        <div class="flex items-center">
          <svg class="h-full w-6 flex-shrink-0 text-gray-200" viewBox="0 0 24 44" preserveAspectRatio="none" fill="currentColor" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
            <path d="M.293 0l22 22-22 22h1.414l22-22-22-22H.293z" />
          </svg>
          <a href="/treasuries/public_companies/#{@public_company.permalink}" class="ml-4 text-sm font-medium text-gray-500 hover:text-gray-700" aria-current="page">#{@public_company.name} (#{@public_company.long_ticker})</a>
        </div>
      </li>
    ).html_safe
    add_breadcrumb public_company
  end
end
