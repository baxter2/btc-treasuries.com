class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :transactionable, polymorphic: true, null: false
      t.datetime :date
      t.text :source_urls, array: true, default: [], using: "(string_to_array(source, ','))"
      t.text :tweet_urls, array: true, default: [], using: "(string_to_array(source, ','))"
      t.string :explanation
      t.decimal :btc, precision: 16, scale: 8
      t.decimal :total_btc_to_date, precision: 16, scale: 8

      t.timestamps
    end
  end
end
