class Transaction < ApplicationRecord
  belongs_to :transactionable, polymorphic: true

  after_save do |transaction|
    total_btc = transaction.transactionable.transactions.pluck(:btc).compact.sum
    transaction.transactionable.update_column :total_btc, total_btc
  end
end
