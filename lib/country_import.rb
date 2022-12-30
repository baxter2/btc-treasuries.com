class CountryImport
  attr_reader :country_data

  def initialize(country_data)
    @country_data = country_data
  end

  def perform
    upsert_country
  end

private
  def upsert_country
    country_data.each do |country_data|
      country = Country.find_or_initialize_by(permalink: country_data["permalink"])
      country.update(
        name: country_data["name"],
        alpha3: country_data["alpha3"]
      )

      upsert_transactions transactions_data: country_data["transactions"], country: country
    end
  end

  def upsert_transactions(transactions_data:, country:)
    transactions_data.each do |transaction_data|
      date = DateTime.parse(transaction_data["date"])

      transaction = Transaction.find_or_initialize_by(date: date, btc: transaction_data["btc"])
      transaction.update(
        transactionable_id: country.id,
        transactionable_type: "Entity",
        source_urls: transaction_data["source_urls"],
        tweet_urls: transaction_data["tweet_urls"]
      )
    end
  end
end
