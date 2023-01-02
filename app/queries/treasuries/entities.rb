class Treasuries::Entities
  attr_accessor :locals
  attr_reader :entities, :transactions, :type

  def initialize(type)
    @type = type
    @entities = Entity.where(type: type).includes(:transactions).sort_by(&:total_btc).reverse
    @transactions = @entities.map(&:transactions).flatten.sort_by(&:date)
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
      label: "All #{type} Holding",
      chart_data: Treasuries::ChartDataQuery.new(transactions).group_by_individual,
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

  def total_purchases
    Treasuries::BtcStatisticsQuery.new(transactions).total_purchases
  end

  def total_sell_offs
    Treasuries::BtcStatisticsQuery.new(transactions).total_sell_offs
  end

  def total_btc
    Treasuries::BtcStatisticsQuery.new(transactions).total_btc
  end

  def total_percent_of_supply
    Treasuries::BtcStatisticsQuery.new(transactions).total_percent_of_supply
  end
end
