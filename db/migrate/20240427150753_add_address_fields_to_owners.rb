# frozen_string_literal: true

class AddAddressFieldsToOwners < ActiveRecord::Migration[7.1]
  def change
    add_column :owners, :street, :string
    add_column :owners, :city, :string
    add_column :owners, :neighborhood, :string
    add_column :owners, :state, :string
    add_column :owners, :zip_code, :string
    add_column :owners, :country, :string
  end
end
