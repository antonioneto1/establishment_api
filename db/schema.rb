# frozen_string_literal: true

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

ActiveRecord::Schema[7.1].define(version: 20_240_427_150_753) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'customers', force: :cascade do |t|
    t.string 'name'
    t.string 'email'
    t.string 'phone'
    t.bigint 'establishment_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['establishment_id'], name: 'index_customers_on_establishment_id'
  end

  create_table 'employees', force: :cascade do |t|
    t.string 'name'
    t.string 'email'
    t.string 'password'
    t.bigint 'establishment_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['establishment_id'], name: 'index_employees_on_establishment_id'
  end

  create_table 'establishments', force: :cascade do |t|
    t.string 'street'
    t.string 'city'
    t.string 'state'
    t.string 'zip_code'
    t.string 'country'
    t.string 'neighborhood'
    t.time 'opening_hours'
    t.jsonb 'coordinates'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'owner_id', null: false
    t.string 'fantasy_name'
    t.string 'name'
    t.string 'phone'
    t.string 'whatsapp'
    t.string 'cnpj'
    t.string 'category'
    t.string 'email'
    t.time 'closing_time'
    t.index ['owner_id'], name: 'index_establishments_on_owner_id'
  end

  create_table 'owners', force: :cascade do |t|
    t.string 'name'
    t.string 'phone'
    t.string 'email'
    t.string 'document_number'
    t.integer 'type_document'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'street'
    t.string 'city'
    t.string 'neighborhood'
    t.string 'state'
    t.string 'zip_code'
    t.string 'country'
  end

  create_table 'pets', force: :cascade do |t|
    t.string 'name'
    t.integer 'age'
    t.bigint 'customer_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['customer_id'], name: 'index_pets_on_customer_id'
  end

  add_foreign_key 'customers', 'establishments'
  add_foreign_key 'employees', 'establishments'
  add_foreign_key 'establishments', 'owners'
  add_foreign_key 'pets', 'customers'
end
