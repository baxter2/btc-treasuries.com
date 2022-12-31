class Entity < ApplicationRecord
  TOTAL_BTC = 21_000_000.0
  attribute :total_btc, :float

  has_many :transactions, -> { order(date: :asc) }, as: :transactionable

  def percent_of_supply
    (total_btc / TOTAL_BTC * 100)
  end
end
