# frozen_string_literal: true

class Owner < ApplicationRecord
  has_many :establishments

  validates :email, :name, :document_number, :type_document, presence: true
  validates :street, :city, :state, :country, :zip_code, :neighborhood, presence: true
  validates :zip_code, presence: true

  validates :document_number, uniqueness: true, allow_blank: true
  validates :email, uniqueness: true, allow_blank: true
  validates :phone, presence: true,
                    format: { with: /\A\d{10,11}\z/, message: 'deve conter apenas números e ter 10 ou 11 dígitos' }

  enum type_document: { cpf: 0, cnh: 1, rg: 2, other: 3 }, _prefix: true

  def full_address
    [street, neighborhood, city, state, zip_code, country].compact.join(', ')
  end

  def profile
    {
      name: name,
      document: "#{type_document} - #{document_number}",
      phone: phone,
      email: email,
      full_address: full_address,
      establishments: establishments.map(&:profile)
    }
  end
end
