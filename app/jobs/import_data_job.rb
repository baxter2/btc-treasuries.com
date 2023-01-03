class ImportDataJob < ApplicationJob
  queue_as :default

  def perform(modified_file)
    case modified_file
    when "countries.json"
      system "rake import:countries"
    when "private_companies.json"
      system "rake import:private_companies"
    when "public_companies.json"
      system "rake import:public_companies"
    end
  end
end
