class PublicCompanyImport
  attr_reader :public_company_data

  def initialize(public_company_data)
    @public_company_data = public_company_data
  end

  def perform
    upsert_public_companies
  end

private
  def upsert_public_companies
    public_company_data.each do |public_company_data|
      public_company = PublicCompany.find_or_initialize_by(permalink: public_company_data["permalink"])
      public_company.update(
        name: public_company_data["name"],
        long_ticker: public_company_data["long_ticker"],
        short_ticker: public_company_data["short_ticker"],
        twitter_url: public_company_data["twitter_url"]
      )

      upsert_transactions transactions_data: public_company_data["transactions"], public_company: public_company
    end
  end

  def upsert_transactions(transactions_data:, public_company:)
    transactions_data.each do |transaction_data|
      date = DateTime.parse(transaction_data["date"])

      transaction = Transaction.find_or_initialize_by(date: date, btc: transaction_data["btc"])
      transaction.update(
        transactionable_id: public_company.id,
        transactionable_type: "Entity",
        source_urls: transaction_data["source_urls"],
        tweet_urls: transaction_data["tweet_urls"]
      )
    end
  end
end
