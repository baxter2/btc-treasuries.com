require 'net/http'
require 'country_import'
require 'public_company_import'
require 'private_company_import'

namespace :import do
  desc "Import countries data from JSON file hosted on GitHub"
  task countries: :environment do
    url = "https://raw.githubusercontent.com/baxter2/data-btc-treasuries.com/master/countries.json"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)
    CountryImport.new(data).perform
  end

  desc "Import public companies data from JSON file hosted on GitHub"
  task public_companies: :environment do
    url = "https://raw.githubusercontent.com/baxter2/data-btc-treasuries.com/master/public_companies.json"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)
    PublicCompanyImport.new(data).perform
  end

  task private_companies: :environment do
    url = "https://raw.githubusercontent.com/baxter2/data-btc-treasuries.com/master/private_companies.json"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)
    PrivateCompanyImport.new(data).perform
  end
end
