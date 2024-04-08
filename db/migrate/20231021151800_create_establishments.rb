class CreateEstablishments < ActiveRecord::Migration[7.0]
  def change
    create_table :establishments do |t|
      t.string :street
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :country
      t.time :opening_hours
      t.jsonb :coordinates

      t.timestamps
    end
  end
end
