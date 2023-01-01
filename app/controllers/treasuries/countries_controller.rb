class Treasuries::CountriesController < ApplicationController
  countries = %Q(
    <li class="flex">
      <div class="flex items-center">
        <svg class="h-full w-6 flex-shrink-0 text-gray-200" viewBox="0 0 24 44" preserveAspectRatio="none" fill="currentColor" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
          <path d="M.293 0l22 22-22 22h1.414l22-22-22-22H.293z" />
        </svg>
        <a href="/treasuries/countries" class="ml-4 text-sm font-medium text-gray-500 hover:text-gray-700">Countries</a>
      </div>
    </li>
  ).html_safe
  add_breadcrumb countries

  def index
    view_object = Treasuries::Entities.new("Country").call
    render locals: view_object.locals
  end

  def show
    @country = Country.find_by_permalink(params[:permalink])
    @transactions = @country.transactions
    @chart_data = Treasuries::ChartDataQuery.new(@transactions).group_by_individual

    country = %Q(
      <li class="flex">
        <div class="flex items-center">
          <svg class="h-full w-6 flex-shrink-0 text-gray-200" viewBox="0 0 24 44" preserveAspectRatio="none" fill="currentColor" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
            <path d="M.293 0l22 22-22 22h1.414l22-22-22-22H.293z" />
          </svg>
          <a href="/treasuries/countries/#{@country.permalink}" class="ml-4 text-sm font-medium text-gray-500 hover:text-gray-700" aria-current="page">#{@country.name}</a>
        </div>
      </li>
    ).html_safe
    add_breadcrumb country
  end
end
