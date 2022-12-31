class Treasuries::Entities
  attr_reader :entities, :type
  attr_accessor :locals

  def initialize(type)
    @type = type
    @entities = Entity.where(type: type).includes(:transactions)
  end

  def call
    self.locals = find_locals
    self
  end

  def find_locals
    {
      entities: entities.sort_by(&:total_btc).reverse,
    }
  end
end
