class PrivateCompanyImport
  attr_reader :private_company_data

  def initialize(private_company_data)
    @private_company_data = private_company_data
  end

  def perform
    upsert_private_companies
  end

private
  def upsert_private_companies
    private_company_data.each do |private_company_data|
      private_company = PrivateCompany.find_or_initialize_by(permalink: private_company_data["permalink"])
      private_company.update(
        name: private_company_data["name"],
        twitter_url: private_company_data["twitter_url"]
      )

      upsert_transactions transactions_data: private_company_data["transactions"], private_company: private_company
    end
  end

  def upsert_transactions(transactions_data:, private_company:)
    transactions_data.each do |transaction_data|
      date = DateTime.parse(transaction_data["date"])

      transaction = Transaction.find_or_initialize_by(date: date, btc: transaction_data["btc"])
      transaction.update(
        transactionable_id: private_company.id,
        transactionable_type: "Entity",
        source_urls: transaction_data["source_urls"],
        tweet_urls: transaction_data["tweet_urls"]
      )
    end
  end
end
