class Treasuries::BtcStatisticsQuery
  attr_reader :transactions

  def initialize(transactions)
    @transactions = transactions
  end

  def btc_before(num_days:)
    total_btc - transactions.select { |t| t.date > num_days.days.ago }.map { |t| t.btc }.compact.sum
  end

  def btc_growth_percent(num_days:)
    (transactions.select { |t| t.date > num_days.days.ago }.map { |t| t.btc}.compact.sum.to_f / total_btc * 100).round(2)
  end

  def total_btc
    transactions.pluck(:btc).sum
  end

  def total_percent_of_supply
    (total_btc / 21_000_000 * 100)
  end

  def total_purchases
    transactions.pluck(:btc).count(&:positive?)
  end

  def total_sell_offs
    transactions.pluck(:btc).count(&:negative?)
  end
end
