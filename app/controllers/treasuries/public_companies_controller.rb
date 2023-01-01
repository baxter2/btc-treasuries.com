class Treasuries::PublicCompaniesController < ApplicationController
  def index
    view_object = Treasuries::Entities.new("PublicCompany").call
    render locals: view_object.locals
  end

  def show
    @public_company = PublicCompany.find_by_permalink(params[:permalink])
    @transactions = @public_company.transactions
    @chart_data = Treasuries::ChartDataQuery.new(@transactions).group_by_individual
  end
end
