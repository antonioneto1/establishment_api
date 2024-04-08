class AddFieldsToEstablishments < ActiveRecord::Migration[7.0]
  def change
    add_column :establishments, :fantasy_name, :string
    add_column :establishments, :name, :string
    add_column :establishments, :phone, :string
    add_column :establishments, :whatsapp, :string
    add_column :establishments, :cnpj, :string
    add_column :establishments, :category, :string
    add_column :establishments, :email, :string
    add_column :establishments, :closing_time, :time
  end
end
