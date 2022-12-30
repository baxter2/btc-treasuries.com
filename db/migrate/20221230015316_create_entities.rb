class CreateEntities < ActiveRecord::Migration[7.0]
  def change
    create_table :entities do |t|
      t.string :type
      t.string :name
      t.string :twitter_url
      t.string :permalink
      t.string :alpha3
      t.string :short_ticker
      t.string :long_ticker
      t.decimal :total_btc, precision: 16, scale: 8

      t.timestamps
    end
  end
end
