class AddOwnerToEstablishments < ActiveRecord::Migration[7.0]
  def change
    unless column_exists?(:establishments, :owner_id)
      add_reference :establishments, :owner, null: false, foreign_key: true
    end
  end
end