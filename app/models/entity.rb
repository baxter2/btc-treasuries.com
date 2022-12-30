class Entity < ApplicationRecord
  has_many :transactions, -> { order(date: :asc) }, as: :transactionable
end
