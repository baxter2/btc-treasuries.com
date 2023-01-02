class TreasuriesController < ApplicationController
  def index
    @entities = Entity.includes(:transactions).sort_by(&:total_btc).reverse
    @transactions = @entities.map(&:transactions).flatten

    @countries_transactions = @entities.select { |e| e.type == "Country" }.map(&:transactions).flatten.sort_by(&:date)
    @private_companies_transactions = @entities.select { |e| e.type == "PrivateCompany" }.map(&:transactions).flatten.sort_by(&:date)
    @public_companies_transactions = @entities.select { |e| e.type == "PublicCompany" }.map(&:transactions).flatten.sort_by(&:date)

    @total_btc_country = @countries_transactions.pluck(:btc).sum
    @total_btc_private_company = @private_companies_transactions.pluck(:btc).sum
    @total_btc_public_company = @public_companies_transactions.pluck(:btc).sum

    @total_btc = @total_btc_country + @total_btc_private_company + @total_btc_public_company

    @countries_chart_data = Treasuries::ChartDataQuery.new(@countries_transactions).group_by_quarter
    @private_companies_chart_data = Treasuries::ChartDataQuery.new(@private_companies_transactions).group_by_quarter
    @public_companies_chart_data = Treasuries::ChartDataQuery.new(@public_companies_transactions).group_by_quarter
  end
end
