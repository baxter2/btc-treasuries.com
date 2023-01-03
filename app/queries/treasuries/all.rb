class Treasuries::All
  attr_accessor :locals
  attr_reader :entities,
              :transactions,
              :countries_transactions,
              :priv_companies_transactions,
              :pub_companies_transactions,
              :total_btc

  def initialize
    @entities = Entity.includes(:transactions).sort_by(&:total_btc).reverse
    @transactions = @entities.map(&:transactions).flatten
    @countries_transactions = transactions_by_entity_type("Country")
    @priv_companies_transactions = transactions_by_entity_type("PrivateCompany")
    @pub_companies_transactions = transactions_by_entity_type("PublicCompany")
  end

  def call
    self.locals = find_locals
    self
  end

private
  def find_locals
    stats = {}
    stats.merge!(find_entities)
    stats.merge!(find_chart_data)
    stats.merge!(find_last_30_days)
    stats.merge!(find_basic_stats)
    stats
  end

  def find_entities
    {
      entities: entities
    }
  end

  def find_chart_data
    {
      countries_chart_data: chart_data(countries_transactions),
      priv_companies_chart_data: chart_data(priv_companies_transactions),
      pub_companies_chart_data: chart_data(pub_companies_transactions)
    }
  end

  def find_last_30_days
    {
      total_btc_country: total_btc_country,
      country_btc_before_30d: btc_before_30d(countries_transactions),
      countries_btc_growth_30d: btc_growth_30d(countries_transactions),

      total_btc_priv_company: total_btc_priv_company,
      priv_company_btc_before_30d: btc_before_30d(priv_companies_transactions),
      priv_companies_btc_growth_30d: btc_growth_30d(priv_companies_transactions),

      total_btc_pub_company: total_btc_pub_company,
      pub_company_btc_before_30d: btc_before_30d(pub_companies_transactions),
      pub_companies_btc_growth_30d: btc_growth_30d(pub_companies_transactions),
    }
  end

  def find_basic_stats
    {
      total_purchases: total_purchases,
      total_sell_offs: total_sell_offs,
      total_btc: total_btc,
      total_percent_of_supply: total_percent_of_supply
    }
  end

  def transactions_by_entity_type(type)
    entities
      .select { |e| e.type == type }
      .map(&:transactions)
      .flatten
      .sort_by(&:date)
  end

  def chart_data(entities)
    Treasuries::ChartDataQuery.new(entities).group_by_quarter
  end

  def total_purchases
    Treasuries::BtcStatisticsQuery.new(transactions).total_purchases
  end

  def total_sell_offs
    Treasuries::BtcStatisticsQuery.new(transactions).total_sell_offs
  end

  def btc_before_30d(entities_transactions)
    Treasuries::BtcStatisticsQuery.new(entities_transactions).btc_before(num_days: 30)
  end

  def btc_growth_30d(entities_transactions)
    Treasuries::BtcStatisticsQuery.new(entities_transactions).btc_growth_percent(num_days: 30)
  end

  def total_btc
    Treasuries::BtcStatisticsQuery.new(transactions).total_btc
  end

  def total_btc_country
    Treasuries::BtcStatisticsQuery.new(countries_transactions).total_btc
  end

  def total_btc_priv_company
    Treasuries::BtcStatisticsQuery.new(priv_companies_transactions).total_btc
  end

  def total_btc_pub_company
    Treasuries::BtcStatisticsQuery.new(pub_companies_transactions).total_btc
  end

  def total_percent_of_supply
    Treasuries::BtcStatisticsQuery.new(transactions).total_percent_of_supply
  end
end
