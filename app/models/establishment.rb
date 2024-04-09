class Establishment < ApplicationRecord
  belongs_to :owner

  def address
    [street, city, state, country, zip_code].compact.join(', ')
  end

  def given_coordinates
    self.coordinates = Geocoder.search(address)[0]
  end
end
