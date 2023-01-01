class Treasuries::PrivateCompaniesController < ApplicationController
  def index
    view_object = Treasuries::Entities.new("PrivateCompany").call
    render locals: view_object.locals
  end

  def show
    @private_company = PrivateCompany.find_by_permalink(params[:permalink])
    @transactions = @private_company.transactions
    @chart_data = Treasuries::ChartDataQuery.new(@transactions).group_by_individual
  end
end
