# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_12_30_015535) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "entities", force: :cascade do |t|
    t.string "type"
    t.string "name"
    t.string "twitter_url"
    t.string "permalink"
    t.string "alpha3"
    t.string "short_ticker"
    t.string "long_ticker"
    t.decimal "total_btc", precision: 16, scale: 8
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.string "transactionable_type", null: false
    t.bigint "transactionable_id", null: false
    t.datetime "date"
    t.text "source_urls", default: [], array: true
    t.text "tweet_urls", default: [], array: true
    t.string "explanation"
    t.decimal "btc", precision: 16, scale: 8
    t.decimal "total_btc_to_date", precision: 16, scale: 8
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transactionable_type", "transactionable_id"], name: "index_transactions_on_transactionable"
  end

end
