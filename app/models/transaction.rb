class Transaction < ApplicationRecord
  belongs_to :transactionable, polymorphic: true
end
