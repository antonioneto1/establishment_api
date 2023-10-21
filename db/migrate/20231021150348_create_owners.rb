class CreateOwners < ActiveRecord::Migration[7.0]
  def change
    create_table :owners do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :document_number
      t.string :type_document

      t.timestamps
    end
  end
end
