class Treasuries::Entities
  attr_reader :entities, :transactions, :type
  attr_accessor :locals

  def initialize(type)
    @type = type
    @entities = Entity.where(type: type).includes(:transactions)
    @transactions = @entities.map(&:transactions).flatten.sort_by(&:date)
  end

  def call
    self.locals = find_locals
    self
  end

  def find_locals
    {
      entities: entities.sort_by(&:total_btc).reverse,

      label: "All #{type} Holding",
      chart_data: Treasuries::ChartDataQuery.new(transactions).group_by_individual,
    }
  end
end
