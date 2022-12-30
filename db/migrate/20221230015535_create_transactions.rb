class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :transactionable, polymorphic: true, null: false
      t.datetime :date
      t.text :source_urls
      t.text :tweet_urls
      t.string :explanation
      t.decimal :btc
      t.decimal :total_btc_to_date

      t.timestamps
    end
  end
end
