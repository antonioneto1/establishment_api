# frozen_string_literal: true

require 'cpf_cnpj'

class Establishment < ApplicationRecord
  belongs_to :owner

  validates :street, :city, :state, :country, :zip_code, :neighborhood, presence: true
  validates :zip_code, presence: true
  validates :cnpj, uniqueness: true, allow_blank: true
  validates :email, uniqueness: true, allow_blank: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: 'deve ser um email válido' }
  validates :whatsapp, presence: true,
                       format: { with: /\A\d{10,11}\z/, message: 'deve conter apenas números e ter 10 ou 11 dígitos' }
  validates :phone, presence: true,
                    format: { with: /\A\d{10,11}\z/, message: 'deve conter apenas números e ter 10 ou 11 dígitos' }

  validate :valid_coordinates
  validate :cnpj_validity

  # before_save :set_coordinates

  def full_address
    [street, neighborhood, city, state, zip_code, country].compact.join(', ')
  end

  def profile
    {
      name: name,
      fantasy_name: fantasy_name,
      category: category,
      cnpj: format_cnpj,
      phone: phone,
      whatsapp: whatsapp,
      email: email,
      owner_name: owner.name,
      opening_hours: "#{opening_hours.strftime('%H:%M')} até as #{closing_time.strftime('%H:%M')}",
      full_address: full_address
    }
  end

  private

  def cnpj_validity
    self.cnpj = CNPJ.new(cnpj).stripped if cnpj.present?
    return if cnpj.blank?

    errors.add(:cnpj, 'inválido') unless CNPJ.valid?(cnpj)
  end

  def format_cnpj
    CNPJ.new(cnpj).formatted
  end

  def valid_coordinates
    return unless coordinates.present? && (coordinates['latitude'].blank? || coordinates['longitude'].blank?)

    errors.add(:coordinates, 'inválidas')
  end

  def set_coordinates
    return if full_address.blank?

    geocoded_data = Geocoder.search(full_address).first
    self.coordinates = if geocoded_data.present?
                         {
                           latitude: geocoded_data.latitude,
                           longitude: geocoded_data.longitude
                         }
                       else
                         { latitude: nil, longitude: nil }
                       end
    save
  end
end
