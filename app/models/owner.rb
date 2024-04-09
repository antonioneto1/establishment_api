class Owner < ApplicationRecord
  has_many :establishments

  validates :email, :name, :phone, :document_number, :type_document, presence: true

  enum type_document: { cpf: 0, cnh: 1, rg: 2, other: 3 }, _prefix: true
end
