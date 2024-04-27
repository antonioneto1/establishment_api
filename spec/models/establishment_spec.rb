# frozen_string_literal: true

# spec/models/user_spec.rb (para RSpec)

require 'rails_helper'

RSpec.describe Establishment, type: :model do
  it 'is valid with valid attributes' do
    establishment = FactoryBot.create(:establishment)
    expect(establishment).to be_valid
    expect(establishment.email).to match(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
    expect(establishment.phone).to match(/\A\d{10,11}\z/)
    expect(establishment.whatsapp).to match(/\A\d{10,11}\z/)
    expect(establishment.cnpj).to be_truthy
    expect(establishment.full_address).to match(/, /)
    expect(establishment.opening_hours).to be_truthy
  end
end
