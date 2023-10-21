class AddEstablishmentsToOwner < ActiveRecord::Migration[7.0]
  def change
    add_reference :establishments, :owner, null: false, foreign_key: true
  end
end
