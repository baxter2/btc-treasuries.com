class Treasuries::CountriesController < ApplicationController
  def index
    view_object = Treasuries::Entities.new("Country").call
    render locals: view_object.locals
  end

  def show
    @country = Country.find_by_permalink(params[:permalink])
    @transactions = @country.transactions
    @chart_data = Treasuries::ChartDataQuery.new(@transactions).group_by_individual
  end
end
