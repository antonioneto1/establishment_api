class Establishment < ApplicationRecord
  belongs_to :owner

  validates :street, :city, :state, :country, :zip_code, presence: true
  validates :zip_code, presence: true, format: { with: /\A\d{5}-\d{3}\z/, message: 'formato inválido. Utilize o formato: 12345-678' }
  validates :cnpj, uniqueness: true, allow_blank: true
  validates :email, uniqueness: true, allow_blank: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'deve ser um email válido' }
  validates :phone, format: { with: /\A\d{10,11}\z/, message: 'deve conter apenas números e ter 10 ou 11 dígitos' }, allow_blank: true
  validates :whatsapp, format: { with: /\A\d{10,11}\z/, message: 'deve conter apenas números e ter 10 ou 11 dígitos' }, allow_blank: true

  validate :valid_coordinates

  #before_validation :set_coordinates

  def full_address
    [street, city, state, country, zip_code].compact.join(', ')
  end

  private

  def valid_coordinates
    if coordinates.present? && (coordinates['latitude'].blank? || coordinates['longitude'].blank?)
      errors.add(:coordinates, 'inválidas')
    end
  end

  def set_coordinates
    return if address.blank?
    geocoded_data = Geocoder.search(address).first
    if geocoded_data.present?
      self.coordinates = {
        latitude: geocoded_data.latitude,
        longitude: geocoded_data.longitude
      }
    else
      errors.add(:address, 'não pôde ser geocodificado')
    end
  end
end
